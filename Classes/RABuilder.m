//
//  Builder.m
//  Core Resource
//
//  Created by Marcus Crafter on 13/07/09.
//  Copyright 2009 Red Artisan. All rights reserved.
//

#import "RABuilder.h"
#import "NSString+Inflections.h"
#import "NSString+DateParsing.h"

@interface RABuilder (PrivateMethods)
-(id)   entityInstanceWithName:(NSString *)name andContext:(NSDictionary *)context;
-(void) setAttributeValue:(NSString *)value forInstance:(id)instance withDescriptor:(NSAttributeDescription *)descriptor;
-(id)   findEntityInstanceWithName:(NSString *)entityName andPrimaryKey:(NSString *)primaryKey;
-(id)   createEntityInstanceWithName:(NSString *)entityName andContext:(NSDictionary *)context;
-(NSString *) primaryKey:(NSDictionary *)context;
@end


@implementation RABuilder

@synthesize managedObjectContext;

-(id) initWithManagedContext:(NSManagedObjectContext *)aManagedObjectContext {
    if (self = [super init]) {
        self.managedObjectContext = aManagedObjectContext;
    }
    
    return self;
}

-(id) create:(NSDictionary *)data {
    for (NSString * className in data) {
        NSDictionary * classData = [data valueForKey:className];
        return [self entityInstanceWithName:className andContext:classData];
    }
    
    return nil;
}

@end

@implementation RABuilder (PrivateMethods)

-(id) entityInstanceWithName:(NSString *)name andContext:(NSDictionary *)context {
    NSString * entityName = [name toClassName];

    id existing = [self findEntityInstanceWithName:entityName andPrimaryKey:[self primaryKey:context]];
    if (existing) {
        return existing;
    }

    return [self createEntityInstanceWithName:entityName andContext:context];
}

-(id) findEntityInstanceWithName:(NSString *)entityName andPrimaryKey:(NSString *)primaryKey {
    NSFetchRequest * request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription * description = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    request.entity = description;

    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"id == %@", primaryKey];
    request.predicate = predicate;

    NSError * error;
    NSMutableArray * results = [[[managedObjectContext executeFetchRequest:request error:&error] mutableCopy] autorelease];
    // REVISIT: check error

    if ([results count] > 0) {
        return [results objectAtIndex:0];
    }

    return nil;
}

-(id) createEntityInstanceWithName:(NSString *)entityName andContext:(NSDictionary *)context {
    id instance = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:managedObjectContext];
    NSEntityDescription * description = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];

    NSDictionary * entityAttributes = [description attributesByName];
    NSDictionary * entityRelationships = [description relationshipsByName];
    
    for (NSString * attribute in context) {
        NSString * attributeName = [attribute camelize];
        NSAttributeDescription * attributeDescriptor = [entityAttributes valueForKey:attributeName];
        NSRelationshipDescription * relationshipDescriptor = [entityRelationships valueForKey:attributeName];
        
        if (attributeDescriptor) {
            [self setAttributeValue:[context valueForKey:attribute] forInstance:instance withDescriptor:attributeDescriptor];
        } else if (relationshipDescriptor) {
            id associated = [self entityInstanceWithName:attribute andContext:[context valueForKey:attribute]];
            [instance setValue:associated forKey:relationshipDescriptor.name];
        } else {
            NSLog(@"ignoring unsupported attribute/relationship %@ for the moment", attribute);
        }
    }
    
    NSLog(@"built instance %@", instance);
    
    return instance;
}

-(void) setAttributeValue:(NSString *)value forInstance:(id)instance withDescriptor:(NSAttributeDescription *)descriptor {
    id attributeValue;
    
    switch (descriptor.attributeType) {
        case NSInteger16AttributeType:
        case NSInteger32AttributeType:
        case NSInteger64AttributeType:
            attributeValue = [NSNumber numberWithInt:[value intValue]];
            break;
        case NSStringAttributeType:
            attributeValue = value;
            break;
        case NSFloatAttributeType:
            attributeValue = [NSNumber numberWithFloat:[value floatValue]];
            break;
        case NSDoubleAttributeType:
            attributeValue = [NSNumber numberWithDouble:[value doubleValue]];
            break;
        case NSDateAttributeType:
            attributeValue = [value dateValue];
            break;
        default:
            NSLog(@"ignoring unsupported type of %@ for now", descriptor.name);
            break;
    }
    
    [instance setValue:attributeValue forKey:descriptor.name];
}

-(NSString *)primaryKey:(NSDictionary *)context {
    return [context valueForKey:@"id"];
}

@end







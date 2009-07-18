//
//  RABuilderTests.m
//  coreresource
//
//  Created by Marcus Crafter on 18/07/09.
//  Copyright 2009 Red Artisan. All rights reserved.
//

#import "RABuilderTestCase.h"
#import "Wine.h"
#import "Region.h"
#import "Vineyard.h"

@implementation RABuilderTestCase

@synthesize builder;

// construction

-(void) testConstructionWithoutManagedObjectContextShouldNotFail {
    builder = [[RABuilder alloc] initWithManagedContext:nil];
    STAssertNotNil(builder, @"nil builder");
}

-(void) testConstructionWithManagedObjectContextShouldNotFail {
    builder = [[RABuilder alloc] initWithManagedContext:self.managedObjectContext];
    STAssertNotNil(builder, @"nil builder");
}

// create object, no data

-(void) testCreationWithoutDataShouldReturnNil {
    builder = [[RABuilder alloc] initWithManagedContext:self.managedObjectContext];
    id instance = [builder create:nil];
    STAssertNil(instance, @"instance not nil");
}

// create object, single entity

-(void) testCreationWithSingleEntityShouldReturnEntity {
    NSDictionary * wine = [NSDictionary dictionaryWithObjectsAndKeys:@"Yering Station Shiraz", @"name", @"Red", @"colour", @"Full body", @"palate", @"2006", @"vintage", nil];
    NSDictionary * content = [NSDictionary dictionaryWithObjectsAndKeys:wine, @"wine", nil];
    
    builder = [[RABuilder alloc] initWithManagedContext:self.managedObjectContext];
    Wine * instance = [builder create:content];
    
    STAssertNotNil(instance, @"nil instance");
    STAssertEquals(instance.name, @"Yering Station Shiraz", @"name not equal");
    STAssertEquals(instance.colour, @"Red", @"colour not equal");
    STAssertEquals(instance.palate, @"Full body", @"palate not equal");
    STAssertEquals([instance.vintage intValue], 2006, @"vintage not equal");
}

// create object, entity including associations

-(void) testCreationWithAssociationsShouldReturnEntityWithAssociations {
    NSDictionary * region = [NSDictionary dictionaryWithObjectsAndKeys:@"Yarra Valley", @"name", nil];
    NSDictionary * vineyard = [NSDictionary dictionaryWithObjectsAndKeys:@"Yering Station", @"name", region, @"region", nil];
    NSDictionary * wine = [NSDictionary dictionaryWithObjectsAndKeys:@"Yering Station Shiraz", @"name", @"Red", @"colour", @"Full body", @"palate", @"2006", @"vintage", vineyard, @"vineyard", nil];
    NSDictionary * content = [NSDictionary dictionaryWithObjectsAndKeys:wine, @"wine", nil];
    
    builder = [[RABuilder alloc] initWithManagedContext:self.managedObjectContext];
    Wine * instance = [builder create:content];
    
    STAssertNotNil(instance, @"nil instance");
    STAssertEquals(instance.vineyard.name, @"Yering Station", @"vineyard name not equal");
}


// create object, entities including same association

-(void) testCreationWithSameAssociatedEntitiesShouldReturnEntitiesWithSameAssociations {
    NSDictionary * region = [NSDictionary dictionaryWithObjectsAndKeys:@"Yarra Valley", @"name", @"1", @"id", nil];
    NSDictionary * vineyard = [NSDictionary dictionaryWithObjectsAndKeys:@"Yering Station", @"name", region, @"region", @"2", @"id", nil];
    NSDictionary * wine1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Yering Station Shiraz", @"name", @"Red", @"colour", @"Full body", @"palate", @"2006", @"vintage", vineyard, @"vineyard", @"3", @"id", nil];
    NSDictionary * wine2 = [NSDictionary dictionaryWithObjectsAndKeys:@"Yering Station Fortified Shiraz", @"name", @"Dark Red", @"colour", @"Strong", @"palate", @"2004", @"vintage", vineyard, @"vineyard", @"4", @"id", nil];
    NSDictionary * content1 = [NSDictionary dictionaryWithObjectsAndKeys:wine1, @"wine", nil];
    NSDictionary * content2 = [NSDictionary dictionaryWithObjectsAndKeys:wine2, @"wine", nil];

    builder = [[RABuilder alloc] initWithManagedContext:self.managedObjectContext];

    Wine * shiraz = [builder create:content1];
    Wine * fortified = [builder create:content2];
    
    STAssertEquals(shiraz.vineyard.id, fortified.vineyard.id, @"vineyards not same");
}


- (void) tearDown {
    [builder release];
    [super tearDown];
}

@end


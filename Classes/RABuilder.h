//
//  Builder.h
//  Core Resource
//
//  Created by Marcus Crafter on 13/07/09.
//  Copyright 2009 Red Artisan. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface RABuilder : NSObject {
    NSManagedObjectContext * managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;

-(id) initWithManagedContext:(NSManagedObjectContext *)aManagedObjectContext;
-(id) create:(NSDictionary *)data;

@end

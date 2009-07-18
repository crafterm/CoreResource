//
//  CoreDataTestCase.h
//  coreresource
//
//  Created by Marcus Crafter on 18/07/09.
//  Copyright 2009 Red Artisan. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class NSManagedObjectModel, NSManagedObjectContext, NSPersistentStoreCoordinator;

@interface CoreDataTestCase : SenTestCase {
    NSManagedObjectModel * managedObjectModel;
    NSManagedObjectContext * managedObjectContext;	    
    NSPersistentStoreCoordinator * persistentStoreCoordinator;
    
}

@property (nonatomic, retain, readonly) NSManagedObjectModel * managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator * persistentStoreCoordinator;

@end

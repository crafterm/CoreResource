//
//  Vineyard.h
//  coreresource
//
//  Created by Marcus Crafter on 18/07/09.
//  Copyright 2009 Red Artisan. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Wine;
@class Region;

@interface Vineyard :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSSet* wines;
@property (nonatomic, retain) Region * region;

@end


@interface Vineyard (CoreDataGeneratedAccessors)
- (void)addWinesObject:(Wine *)value;
- (void)removeWinesObject:(Wine *)value;
- (void)addWines:(NSSet *)value;
- (void)removeWines:(NSSet *)value;

@end


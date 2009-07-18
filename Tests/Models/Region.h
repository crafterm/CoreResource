//
//  Region.h
//  coreresource
//
//  Created by Marcus Crafter on 18/07/09.
//  Copyright 2009 Red Artisan. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Vineyard;

@interface Region :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSSet* vineyards;

@end


@interface Region (CoreDataGeneratedAccessors)
- (void)addVineyardsObject:(Vineyard *)value;
- (void)removeVineyardsObject:(Vineyard *)value;
- (void)addVineyards:(NSSet *)value;
- (void)removeVineyards:(NSSet *)value;

@end


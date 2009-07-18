//
//  Wine.h
//  coreresource
//
//  Created by Marcus Crafter on 18/07/09.
//  Copyright 2009 Red Artisan. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Vineyard;

@interface Wine :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * colour;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * vintage;
@property (nonatomic, retain) NSString * palate;
@property (nonatomic, retain) Vineyard * vineyard;

@end




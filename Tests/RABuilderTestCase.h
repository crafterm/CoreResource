//
//  RABuilderTests.h
//  coreresource
//
//  Created by Marcus Crafter on 18/07/09.
//  Copyright 2009 Red Artisan. All rights reserved.

#import <Foundation/Foundation.h>
#import "CoreDataTestCase.h"
#import "CoreResource.h"

@interface RABuilderTestCase : CoreDataTestCase {    
    RABuilder * builder;
}

@property (nonatomic, retain) RABuilder * builder;

@end

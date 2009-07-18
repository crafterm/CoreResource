//
//  NSDate+Parsing.m
//  Core Resource
//
//  Created by Marcus Crafter on 28/06/09.
//  Copyright 2009 Red Artisan. All rights reserved.
//

#import "NSString+DateParsing.h"

@implementation NSString (DateParsing)

- (NSDate *)dateValue {
    NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
    NSString * format = ([self hasSuffix:@"Z"]) ? @"yyyy-MM-dd'T'HH:mm:ss'Z'" : @"yyyy-MM-dd'T'HH:mm:ssz";
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    return [formatter dateFromString:self];
}

@end

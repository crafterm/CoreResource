//
//  Service.h
//  Core Resource
//
//  Created by Marcus Crafter on 28/06/09.
//  Copyright 2009 Red Artisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RAService;

@protocol RAServiceDelegate <NSObject>
@optional
-(void) service:(RAService *)service didFinishWithData:(NSData *)data;
-(void) service:(RAService *)service didFailWithError:(NSError *)error;
@end


@interface RAService : NSObject {
    NSMutableData * receivedData;
    id delegate;
    SEL finishedSelector;
    SEL failedSelector;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL finishedSelector;
@property (nonatomic, assign) SEL failedSelector;

-(void)  fetchURL:(NSURL *)url 
         delegate:(id)delegate 
didFinishSelector:(SEL)finishSelector 
  didFailSelector:(SEL)failSelector;

@end

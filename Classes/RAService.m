//
//  RAService.m
//  Core Resource
//
//  Created by Marcus Crafter on 28/06/09.
//  Copyright 2009 Red Artisan. All rights reserved.
//

#import "RAService.h"

@implementation RAService

@synthesize delegate, finishedSelector, failedSelector;

-(void) fetchURL:(NSURL *)url 
        delegate:(id)theDelegate
didFinishSelector:(SEL)finishSelector 
 didFailSelector:(SEL)failSelector {
    
    self.finishedSelector = finishSelector;
    self.failedSelector = failSelector;
    self.delegate = theDelegate;
    
    NSURLRequest * theRequest = [NSURLRequest requestWithURL:url
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:60.0];
    
    NSURLConnection * theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection) {
        receivedData = [[NSMutableData data] retain];
    } else {
        // inform the user that the download could not be made
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    [connection release];
    [receivedData release];

    if ([self.delegate respondsToSelector:failedSelector]) {
        [self.delegate performSelector:failedSelector withObject:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self.delegate respondsToSelector:finishedSelector]) {
        [self.delegate performSelector:finishedSelector withObject:receivedData];
    }
    
    [connection release];
    [receivedData release];
}

@end


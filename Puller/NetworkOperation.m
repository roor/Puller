//
//  NetworkOperation.m
//  Puller
//
//  Created by Artem Podustov on 5/12/15.
//  Copyright (c) 2015 Intersog.com. All rights reserved.
//

#import "NetworkOperation.h"

@implementation NetworkOperation

- (instancetype)initWithRequest:(NSURLRequest *)request completionHandler:(NetworkOperationCompletionBlock)completionHandler {
    self = [self init];
    
    if (self) {
        _request = [request copy];
        _networkOperationCompletionBlock = [completionHandler copy];
    }
    
    return self;
}

- (void)main {
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:self.request returningResponse:&response error:&error];
    
    self.networkOperationCompletionBlock(responseData, error);
    self.networkOperationCompletionBlock = nil;
}

@end

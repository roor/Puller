//
//  NetworkOperation.h
//  Puller
//
//  Created by Artem Podustov on 5/12/15.
//  Copyright (c) 2015 Intersog.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkOperationCompletionBlock)(NSData *data, NSError *error);

@interface NetworkOperation : NSOperation

@property (nonatomic, copy) NetworkOperationCompletionBlock networkOperationCompletionBlock;
@property (nonatomic, copy) NSURLRequest *request;

- (instancetype)initWithRequest:(NSURLRequest *)request completionHandler:(NetworkOperationCompletionBlock)completionHandler;

@end

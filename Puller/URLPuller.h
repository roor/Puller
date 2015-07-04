//
//  URLPuller.h
//  Puller
//
//  Created by Artem Podustov on 5/12/15.
//  Copyright (c) 2015 Intersog.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLPuller : NSObject

- (void)downloadUrlsAsync:(NSArray *)urls;
- (void)waitUntillAllDownloadsFinish;
- (NSString *)downloadedPathForURL:(NSURL *)url;

@end

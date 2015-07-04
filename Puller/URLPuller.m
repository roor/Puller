//
//  URLPuller.m
//  Puller
//
//  Created by Artem Podustov on 5/12/15.
//  Copyright (c) 2015 Intersog.com. All rights reserved.
//

#import "URLPuller.h"
#import "NetworkOperation.h"


@interface URLPuller()

@property (nonatomic, strong) NSOperationQueue *downoadingQueue;

@end


@implementation URLPuller 


- (instancetype)init {
    self = [super init];
    if (self) {
        _downoadingQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)downloadUrlsAsync:(NSArray *)urls {
    for (NSURL *url in urls) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NetworkOperation *networkOperation = [[NetworkOperation alloc] initWithRequest:request completionHandler:^(NSData *data, NSError *error) {
            if (nil == error) {
                
                //{sha1 hash of url}.downloaded
                //so we do expect sha1 hash and not trying to remove .jpg etc
                [self saveData:data toFileNamed:request.URL.lastPathComponent];
                NSLog(@"save %@", request.URL.lastPathComponent);
            }
        }];
        
        [self.downoadingQueue addOperation:networkOperation];
    }
}

- (NSString *)downloadedPathForURL:(NSURL *)url {
    NSString *filePath = [[self documentDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.downloaded", url.lastPathComponent]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return filePath;
    }
    
    return nil;
}

- (void)waitUntillAllDownloadsFinish {
    [self.downoadingQueue waitUntilAllOperationsAreFinished];
}

#pragma mark - internal

- (void)saveData:(NSData *)data toFileNamed:(NSString *)name {
    
    NSString *file = [[self documentDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.downloaded", name]];
    
    [data writeToFile:file atomically:YES];
}

- (NSString *)documentDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths firstObject];
}


@end

//
//  ViewController.m
//  Puller
//
//  Created by Artem Podustov on 5/12/15.
//  Copyright (c) 2015 Intersog.com. All rights reserved.
//

#import "ViewController.h"
#import "URLPuller.h"

@interface ViewController ()

@property (nonatomic, strong) URLPuller *urlPuller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.urlPuller = [URLPuller new];
    
    NSArray *urls = @[
                     [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/2/24/Willaerts_Adam_The_Embarkation_of_the_Elector_Palantine_Oil_Canvas-huge.jpg"], //big image
                     [NSURL URLWithString:@"http://www.dreamhost.com/blog/wp-content/uploads/2008/05/multitool.jpg"] //small image
                     ];
    
    dispatch_queue_t queue = dispatch_queue_create("com.URLPuller", 0);
    
    dispatch_async(queue, ^{ //it is a bad idea to wait in main thread, so we will wait in other
        NSLog(@"start");
        [self.urlPuller downloadUrlsAsync:urls];
        
        NSLog(@"wait for it");
        
        [self.urlPuller waitUntillAllDownloadsFinish];
        
        NSLog(@"all tasks had been completed");
        
        NSString *path = [self.urlPuller downloadedPathForURL:[NSURL URLWithString:@"http://www.dreamhost.com/blog/wp-content/uploads/2008/05/multitool.jpg"]];
        
        NSLog(@"%@", path);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

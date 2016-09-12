//
//  CustomImageView.m
//  GoGallery
//
//  Created by Anton A on 12.09.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

- (void)configureWithURL:(NSURL *)url {
    
    self.image = [UIImage imageNamed:@"placeholder.png"];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:5.0];
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = image;
                });
            }
        }
    }];
    [task resume];
    
    
}

@end

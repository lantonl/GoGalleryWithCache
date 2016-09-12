//
//  CellArtworkCollectionView.m
//  GoGallery
//
//  Created by Anton A on 31.08.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "CellArtworkCollectionView.h"
#import "ImageLoader.h"

@implementation CellArtworkCollectionView



- (void)configureWithArtwork:(Artwork *) artworkObj{
    
    self.artwork.image = [UIImage imageNamed:@"placeholder.png"];

    [[ImageLoader sharedLoader]loadObjectImageWithCheckCacheAndCompletionBlock:artworkObj andResultBlock:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.artwork.image = image;
        });
    }];
}


/*
NSURL *url = artworkObj.imgPicture;
NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:5.0];
NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.artwork.image = image;
            });
        }
    }
}];
[task resume];
*/







@end

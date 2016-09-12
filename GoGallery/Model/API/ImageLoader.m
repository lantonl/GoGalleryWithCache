//
//  ImageLoader.m
//  GoGallery
//
//  Created by Anton A on 12.09.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "ImageLoader.h"

static NSString *const artworksFolderName = @"Artworks";

@interface ImageLoader()

@property (nonatomic, strong) NSURL *artworksFolderPath;


@end

@implementation ImageLoader

+ (ImageLoader *)sharedLoader {
    static ImageLoader *_sharedLoader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLoader = [[ImageLoader alloc] init];
    });
    
    return _sharedLoader;
}

- (id)init {
    if (self = [super init]) {
        [self createImageFolder];
    }
    return self;
}



- (void)createImageFolder{
    
    NSFileManager *fileManager = [NSFileManager new];
    NSError *err = nil;
    NSURL *docsurl =
    [fileManager URLForDirectory:NSDocumentDirectory
               inDomain:NSUserDomainMask appropriateForURL:nil
                 create:YES error:&err];
    NSURL *artworksFolder = [docsurl URLByAppendingPathComponent:artworksFolderName];
    self.artworksFolderPath = artworksFolder;
    if(![[NSFileManager defaultManager] fileExistsAtPath:[artworksFolder path]]){
        [fileManager createDirectoryAtURL:artworksFolder
              withIntermediateDirectories:YES attributes:nil error:&err];
        NSLog(@"CREATED DIRECTORY");
    }
    
}




- (void) loadObjectImageWithCheckCacheAndCompletionBlock:(Artwork *)artwork andResultBlock:(resultBlock) resultBlock{
    __block UIImage* image;
    
    NSURL *path = [self.artworksFolderPath URLByAppendingPathComponent:
    [NSString stringWithFormat:@"%@.jpg", artwork.ID]];
    image = [UIImage imageWithContentsOfFile:[path path]];
    if (image){
        resultBlock(image);
    }else{
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL: artwork.imgPicture cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:5.0];
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            image = [UIImage imageWithData:data];
             NSData *data = UIImageJPEGRepresentation(image, 0);
             NSURL *path = [self.artworksFolderPath URLByAppendingPathComponent:artwork.ID];
            [data writeToFile:[path path] atomically:YES];
            if (image) {
            resultBlock(image);
            }
        }
    }];
    [task resume];
  }

}


@end

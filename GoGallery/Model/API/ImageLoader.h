//
//  ImageLoader.h
//  GoGallery
//
//  Created by Anton A on 12.09.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Artwork.h"

@interface ImageLoader : NSObject

typedef void (^resultBlock) (UIImage* image);

+ (ImageLoader *)sharedLoader;

- (void) loadObjectImageWithCheckCacheAndCompletionBlock:(Artwork *)artwork andResultBlock:(resultBlock) resultBlock;


@end

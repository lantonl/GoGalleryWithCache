//
//  CustomImageView.h
//  GoGallery
//
//  Created by Anton A on 12.09.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artwork.h"


@interface CustomImageView : UIImageView


- (void)configureWithURL:(NSURL *)url;

@end

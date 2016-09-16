//
//  CellExhibition.m
//  GoGallery
//
//  Created by Anton A on 25.08.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "CellExhibition.h"
#import <CoreLocation/CoreLocation.h>


@implementation CellExhibition

- (void)configureWithExhibition:(Exhibition *)exhibition andLocation:(CLLocation*)userLocation {
    self.exhibitionPreviewImage.image = [UIImage imageNamed:@"no-image-available.jpg"];
    self.exhibitionPreviewImage.contentMode = UIViewContentModeScaleToFill;
    self.galleryNameLabel.text = exhibition.gallery.name;
    self.exhibitionNameLabel.text = exhibition.name;
    self.authorExhibitionLabel.text = exhibition.authorName;
    self.distance.text = [NSString stringWithFormat:@"%.2f km",[userLocation distanceFromLocation:exhibition.gallery.location]/1000.0];
}
    





@end

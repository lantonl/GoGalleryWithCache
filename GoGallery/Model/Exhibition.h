//
//  Exhibition.h
//  GoGallery
//
//  Created by Kirill Kirikov on 8/22/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "Event.h"
#import "Artwork.h"
#import "Gallery.h"

@interface Exhibition : Event
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *authorDescription;
@property (nonatomic, strong) NSArray  *artworks;
@property (nonatomic, strong) Gallery  *gallery;

@end

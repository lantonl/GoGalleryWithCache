//
//  CellArtworkCollectionView.h
//  GoGallery
//
//  Created by Anton A on 31.08.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artwork.h"


@interface CellArtworkCollectionView : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *artwork;

- (void)configureWithArtwork:(Artwork *) artwork;

@end

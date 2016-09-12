//
//  CellExhibition.h
//  GoGallery
//
//  Created by Anton A on 25.08.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsModel.h"
#import "Exhibition.h"
#import "Artwork.h"

@interface CellExhibition : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *galleryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *exhibitionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorExhibitionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *exhibitionPreviewImage;




- (void)configureWithExhibition:(Exhibition *) exhibition;

@end

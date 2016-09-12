//
//  ArtworkDescriptionViewController.m
//  GoGallery
//
//  Created by Anton A on 31.08.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "ArtworkDescriptionViewController.h"
#import "ImageLoader.h"

@interface ArtworkDescriptionViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *artworkImage;

@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *artworkNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;


@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;

@end


@implementation ArtworkDescriptionViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
    

    self.authorLabel.text      = self.artwork.author;
    self.artworkNameLabel.text = self.artwork.title;
    self.yearLabel.text        = self.artwork.year;
    self.descriptionLabel.text = self.artwork.type;
    self.sizeLabel.text        = self.artwork.size;
    
    [[ImageLoader sharedLoader]loadObjectImageWithCheckCacheAndCompletionBlock:self.artwork andResultBlock:^(UIImage *image) {
        self.artworkImage.image = image;
    }];
    

}

-(void) viewWillAppear:(BOOL)animated{
    UIImage* image = [UIImage imageNamed:@"closel@3x.png"];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }





@end

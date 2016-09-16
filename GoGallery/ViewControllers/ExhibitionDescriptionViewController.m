//
//  ExhibitionDescriptionViewController.m
//  GoGallery
//
//  Created by Anton A on 28.08.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "ExhibitionDescriptionViewController.h"
#import "galleryDescriptionViewController.h"
#import "CellArtworkCollectionView.h"
#import "ArtworkDescriptionViewController.h"
#import "EventsModel.h"
#import "CustomImageView.h"
#import "ImageLoader.h"

static NSString *kCellArtworkIdentifier = @"cellArtwork";


@interface ExhibitionDescriptionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>


@property (weak, nonatomic)   IBOutlet     UILabel *exhibitionName;
@property (weak, nonatomic)   IBOutlet     UILabel *exibitionAuthor;
@property (weak, nonatomic)   IBOutlet     UILabel *theDaysOfExibition;
@property (weak, nonatomic)   IBOutlet     UILabel *galleryName;
@property (strong, nonatomic) IBOutlet CustomImageView *galleryLogo;
@property (strong, nonatomic) IBOutlet      UIView *tableWievContainer;
@property (strong, nonatomic) IBOutlet     UILabel *galleryAbout;
@property (strong, nonatomic) IBOutlet      UIView *galleryDescriptionView;
@property (strong, nonatomic) IBOutlet    UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *aboutBottomLabel;

@property (strong, nonatomic) IBOutlet UILabel *theArtistBottomLabel;
@property (strong, nonatomic) IBOutlet UILabel *linksBottomLabel;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *galleryAboutLabelHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewContainerConstraint;

@property (assign, nonatomic) BOOL isShown;



@end



@implementation ExhibitionDescriptionViewController



- (void) viewDidLoad {
    [super viewDidLoad];
    self.isShown = NO;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableViewContainerConstraint.constant = 0;
    self.galleryAboutLabelHeightConstraint.constant = 0;
    
    
    self.exhibitionName.text     = self.exhibition.name;
    self.exibitionAuthor.text    = self.exhibition.authorName;
    self.theDaysOfExibition.text = [self.exhibition convertTheDaysOfEventToString];
    
   
    self.galleryName.text        = self.exhibition.gallery.name;
    [self.galleryLogo configureWithURL:self.exhibition.gallery.logo];

    
    self.aboutBottomLabel.text      = self.exhibition.about;
    self.theArtistBottomLabel.text  = self.exhibition.authorDescription;
    self.linksBottomLabel.text      = self.exhibition.links;
    
    
    [[EventsModel sharedModel]loadExhibitionDescription:self.exhibition withCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
}


-(void) viewWillAppear:(BOOL)animated{
    UIImage* image = [UIImage imageNamed:@"arrow@3x.png"];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        self.navigationController.navigationBarHidden = YES;
        
    }
}



#pragma mark - UIViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"galleryDescriptionSegue"])
    {
        [segue.destinationViewController setGallery:self.exhibition.gallery];
    }else{
        ArtworkDescriptionViewController *viewController = segue.destinationViewController;
        viewController.artwork = (Artwork*)sender;
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.exhibition.artworks count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CellArtworkCollectionView *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:kCellArtworkIdentifier forIndexPath:indexPath];
    Artwork* artwork = [self.exhibition.artworks objectAtIndex:indexPath.row];
    [cell configureWithArtwork:artwork];
    return cell;
}
    



#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Artwork* artwork = [self.exhibition.artworks objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowArtworkDescriptionSegue" sender:artwork];
}

#pragma - Buttons Action

- (IBAction)didTouchInfoButton:(id)sender {
    if (!self.isShown) {
        self.tableViewContainerConstraint.constant = 220;
        self.galleryAbout.text = self.exhibition.gallery.about;
        [UIView animateWithDuration:1.0 animations:^{
            [self.view layoutIfNeeded];
              CGFloat arrowDown = -1;
            CGAffineTransform transform = CGAffineTransformMakeRotation(((arrowDown != 1)? -M_PI:-0.000001));
            self.infoButton.transform = transform;
        }];
        self.isShown = true;
    } else {
        self.tableViewContainerConstraint.constant = 0;
        self.galleryAboutLabelHeightConstraint.constant = 0;
        self.galleryAbout.text = @"";
        [UIView animateWithDuration:1.0 animations:^{
            [self.view layoutIfNeeded];
            CGAffineTransform transform = CGAffineTransformMakeRotation(-0.000001);
            self.infoButton.transform = transform;
            //         self.infoButton.transform = CGAffineTransformMakeRotation(0.0*M_PI/360.0);
        }];
        self.isShown = false;
    }
}






@end

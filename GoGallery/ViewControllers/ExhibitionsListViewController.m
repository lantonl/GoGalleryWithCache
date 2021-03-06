//
//  ExhibitionsListViewController.m
//  GoGallery
//
//  Created by Anton A on 25.08.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "ExhibitionsListViewController.h"
#import "ExhibitionDescriptionViewController.h"
#import "Exhibition.h"
#import "EventsModel.h"
#import "CellExhibition.h"
#import "User.h"

static NSUInteger    kFirstSkip = 0;
static NSString     *kCellExhibitionIdentifier    = @"CellExhibition";
static NSString     *kNotSortedGalleriesRequest   = @"";
static NSString     *kMostPopularGalleriesRequest = @"/popular";
static NSString     *kLastChanceGalleriesRequest  = @"/lastchance";
static NSString     *kOpeningGalleriesRequest     = @"/opening";



@interface ExhibitionsListViewController() <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic)   IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *openMenuButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *menuViewConstraint;

@property (strong, nonatomic) NSString   *requestString;
@property (assign, nonatomic) NSUInteger loadedGalleries;

@property (strong, nonatomic) CLLocation *userLocation;

@end



@implementation ExhibitionsListViewController{
    CLLocationManager *locationManager;
    
}


- (void) viewDidLoad {
    [super viewDidLoad];
    self.menuViewConstraint.constant              = 0;
    self.navigationController.navigationBarHidden = YES;
    self.tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
    self.openMenuButton.layer.masksToBounds       = YES;
    self.openMenuButton.layer.borderColor         = [UIColor whiteColor].CGColor;
    self.openMenuButton.layer.cornerRadius        = 12.0;
    self.openMenuButton.layer.borderWidth         = 2.0;
    [self.openMenuButton setImage:[UIImage imageNamed:@"arrowdown.png"] forState:UIControlStateNormal];
    
    locationManager = [[CLLocationManager alloc] init];
    [self getCurrentLocation];
    
    
    
    self.requestString = kNotSortedGalleriesRequest;
    [[EventsModel sharedModel] loadDataWithSkipCounterAndSortString:kFirstSkip
                                                      andSortString:self.requestString
                                                 andCompletionBlock:^{
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView reloadData];
                                                        });
                                                    }];
    
    
    
}



#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Exhibition* exhibition = (Exhibition*)[[[EventsModel sharedModel]events]objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowExhibitionDescriptionSegue" sender:exhibition];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger counter = [[[EventsModel sharedModel]events] count];
    if (indexPath.row == counter - 1 && counter >= 10){
        self.loadedGalleries += 10;
        [[EventsModel sharedModel] loadDataWithSkipCounterAndSortString:self.loadedGalleries
                                                          andSortString:self.requestString
                                                     andCompletionBlock:^{
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  [self.tableView reloadData];
                                                              });
                                                          }];
}
    
}




#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger count = [[[EventsModel sharedModel]events] count];
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:                                 kCellExhibitionIdentifier];
    Exhibition* exhibition = (Exhibition*)[[[EventsModel sharedModel]events]objectAtIndex:indexPath.row];
    [(CellExhibition*)cell configureWithExhibition:exhibition andLocation:self.userLocation];
    return cell;
}


#pragma mark - UIViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id) sender{
    ExhibitionDescriptionViewController* viewController = segue.destinationViewController;
    viewController.exhibition = (Exhibition*)sender;
}



#pragma mark - Get Current Location


- (void)getCurrentLocation{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
}



#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    NSLog(@"didFailWithError: %@", error);
    
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to Get Your Location" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [errorAlert addAction:ok];
    
    [self presentViewController:errorAlert animated:YES completion:nil];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
  
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.userLocation = [[CLLocation alloc]initWithLatitude:currentLocation.coordinate.latitude longitude: currentLocation.coordinate.longitude];
        [locationManager stopUpdatingLocation];
    }
}







#pragma mark - Buttons Action

- (IBAction)didTouchOpenMenuButton:(id)sender {
    self.openMenuButton.hidden = YES;
    self.menuViewConstraint.constant = 800;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];

    
}

- (IBAction)didTouchCloseMenuButton:(id)sender {
    
    self.menuViewConstraint.constant = 0;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.openMenuButton.hidden = NO;
}


- (IBAction)didTouchNearMeButton:(id)sender {
    [self.openMenuButton setTitle:@"Near me" forState:UIControlStateNormal];
    self.menuViewConstraint.constant = 0;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.openMenuButton.hidden = NO;
}

- (IBAction)didTouchMostPopularButton:(id)sender {
    self.loadedGalleries = kFirstSkip;
    self.requestString = kMostPopularGalleriesRequest;
    [[EventsModel sharedModel] loadDataWithSkipCounterAndSortString:kFirstSkip
                                                      andSortString:self.requestString
                                                 andCompletionBlock:^{
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [self.tableView reloadData];
                                                     });
                                                 }];
    self.menuViewConstraint.constant = 0;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
    [self.openMenuButton setTitle:@"Most popular" forState:UIControlStateNormal];
    self.openMenuButton.hidden = NO;
}

- (IBAction)didtouchOpeningButton:(id)sender {
    self.loadedGalleries = kFirstSkip;
    self.requestString = kOpeningGalleriesRequest;
    [[EventsModel sharedModel] loadDataWithSkipCounterAndSortString:kFirstSkip
                                                      andSortString:self.requestString
                                                 andCompletionBlock:^{
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [self.tableView reloadData];
                                                     });
                                                 }];

    self.menuViewConstraint.constant = 0;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
    [self.openMenuButton setTitle:@"Opening" forState:UIControlStateNormal];
    self.openMenuButton.hidden = NO;
    [self.tableView reloadData];
}

- (IBAction)didTouchLastChanseButton:(id)sender {
    self.loadedGalleries = kFirstSkip;
    self.requestString = kLastChanceGalleriesRequest;
    self.menuViewConstraint.constant = 0;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
    [self.openMenuButton setTitle:@"Last chanse" forState:UIControlStateNormal];
    self.openMenuButton.hidden = NO;
}


- (IBAction)didTouchFollowingButton:(id)sender {
    [self.openMenuButton setTitle:@"Following" forState:UIControlStateNormal];
    self.menuViewConstraint.constant = 0;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.openMenuButton.hidden = NO;
}




@end

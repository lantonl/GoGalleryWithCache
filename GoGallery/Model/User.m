//
//  User.m
//  GoGallery
//
//  Created by Anton A on 02.09.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "User.h"


@implementation User {
    CLLocationManager *locationManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
         locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (void)getCurrentLocation {
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation == nil) {
        NSLog(@"%@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        NSLog(@"%@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
    }
}

@end

//
//  User.h
//  GoGallery
//
//  Created by Anton A on 02.09.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface User : NSObject <CLLocationManagerDelegate>


- (void)getCurrentLocation;
//@property (strong, nonatomic) CLLocation* currentUserLocation;
//@property (strong, nonatomic) CLLocationManager* locationManager;

@end

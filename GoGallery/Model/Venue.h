//
//  Venue.h
//  GoGallery
//
//  Created by Kirill Kirikov on 8/19/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Venue : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSURL *logo;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) CLLocation *location;

- (instancetype) initWithDictionary:(NSDictionary *)data;

@end

//
//  Venue.m
//  GoGallery
//
//  Created by Kirill Kirikov on 8/19/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "Venue.h"

@implementation Venue



- (instancetype) initWithDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.ID = data[@"_id"];
        self.name = data[@"name"];
        self.city = data[@"city"];
        self.about = data[@"galleryDescription"];
        self.address = data[@"address"];
        self.link = data[@"link"];
        self.phone = data[@"phone"];
        self.location = [[CLLocation alloc]initWithLatitude:[data[@"latitude"] floatValue] longitude:[data[@"longitude"] floatValue]];
        
    }
    return self;
}

@end

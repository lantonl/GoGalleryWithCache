//
//  Gallery.m
//  GoGallery
//
//  Created by Kirill Kirikov on 8/22/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "Gallery.h"

@implementation Gallery


- (instancetype) initWithDictionary:(NSDictionary *)data {
    self = [super initWithDictionary:data];
    if (self) {
        self.email    = data[@"email"];
        self.facebook = data[@"facebook"];
        self.schedule = data[@"schedule"];
    }
    return self;
}


@end

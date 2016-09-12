//
//  Artwork.m
//  GoGallery
//
//  Created by Anton A on 23.08.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "Artwork.h"

@implementation Artwork


- (instancetype) initWithDictionary:(NSDictionary *)data{
    self = [super init];
    if (self) {
        self.ID       = data[@"objectId"];
        self.type     = data[@"type"];
        self.year     = data[@"year"];
        self.author   = data[@"author"];
        self.title    = data[@"title"];
        self.size     = data[@"size"];
        self.fileName = data[@"name"];
        
    }
    return self;
}




@end

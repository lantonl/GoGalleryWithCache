//
//  Event.h
//  GoGallery
//
//  Created by Kirill Kirikov on 8/19/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Venue.h"
#import "Artwork.h"

@interface Event : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSDate   *dateStart;
@property (nonatomic, strong) NSDate   *dateEnd;
@property (nonatomic, strong) NSString *links;
@property (nonatomic, strong) Venue    *venue;

- (instancetype) initWithDictionary:(NSDictionary *)data;
- (NSString*) convertTheDaysOfEventToString;
@end

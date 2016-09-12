//
//  EventsModel.h
//  GoGallery
//
//  Created by Kirill Kirikov on 8/19/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "Exhibition.h"

typedef void(^completionBlock)();



@interface EventsModel : NSObject
+ (EventsModel *)sharedModel;
- (NSArray<Event *> *) events;



- (void) loadDataWithSkipCounterAndSortString:(NSUInteger)skip andSortString:(NSString*) string andCompletionBlock:(completionBlock)compBlock;
- (void) loadExhibitionDescription:(Exhibition*) exhibition withCompletionBlock:(completionBlock) compBlock;


@end

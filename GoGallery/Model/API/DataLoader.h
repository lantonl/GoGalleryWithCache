//
//  DataLoader.h
//  GoGallery
//
//  Created by Kirill Kirikov on 8/19/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "Venue.h"
#import "Exhibition.h"


@protocol DataLoaderProtocol <NSObject>

typedef void (^resultBlock)         (NSArray<Event *> * events);
typedef void (^errorBlock)          (NSError *error);
typedef void (^exibitionResultBlock)(Exhibition* exibition);
typedef void (^completionBlock)();


@optional
- (void) exhibitionsFromServerWithSkipCountSortStringAndCallback:(NSUInteger) skipCount andSortString:(NSString *)string andResult:(resultBlock) resultCallback andError:(errorBlock) errorCallback;
- (void) exhibitionDescriptionFromServerWithCallback:(Exhibition*) exhibition andError:(errorBlock) errorCallback andCompletionBlock:(completionBlock)compBlock;
@end

@interface DataLoader : NSObject <DataLoaderProtocol>
- (void) exhibitionsFromServerWithSkipCountSortStringAndCallback:(NSUInteger) skipCount andSortString:(NSString *)string andResult:(resultBlock) resultCallback andError:(errorBlock) errorCallback;
- (void) exhibitionDescriptionFromServerWithCallback:(Exhibition*) exhibition andError:(errorBlock) errorCallback andCompletionBlock:(completionBlock)compBlock;;
@end

@interface APIDataLoader : NSObject <DataLoaderProtocol>

@end
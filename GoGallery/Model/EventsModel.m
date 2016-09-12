//
//  EventsModel.m
//  GoGallery
//
//  Created by Kirill Kirikov on 8/19/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "EventsModel.h"

#import "DataLoader.h"

@interface EventsModel()
@property (nonatomic, strong) NSMutableArray <Event *> *tempEvents;
@property (nonatomic, strong) Exhibition *exhibition;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id<DataLoaderProtocol> dataLoader;
@property (nonatomic, strong) NSString* checkString;
@property (nonatomic, strong) dispatch_queue_t concurrentExhibitionsQueue;
@end

@implementation EventsModel




+ (EventsModel *)sharedModel {
    static EventsModel *_sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[EventsModel alloc] init];
    });
    
    return _sharedModel;
}

- (id)init {
    if (self = [super init]) {
        self.dataLoader = [[DataLoader alloc] init];
        self.tempEvents = [[NSMutableArray alloc]init];
        self.concurrentExhibitionsQueue = dispatch_queue_create("com.Gallery.ExhibitionsQueue",
                                                     DISPATCH_QUEUE_CONCURRENT);
        self.checkString = @"";
    }
    return self;
}



- (void) loadDataWithSkipCounterAndSortString:(NSUInteger)skip andSortString:(NSString*) string
                           andCompletionBlock:(completionBlock)compBlock {
    __weak typeof(self) weakself = self;
    if ([self.checkString isEqualToString:string]){
        [self.dataLoader exhibitionsFromServerWithSkipCountSortStringAndCallback:skip andSortString:string
            andResult:^(NSArray<Event *> *events) {
                dispatch_barrier_async(self.concurrentExhibitionsQueue, ^{
                    [weakself.tempEvents addObjectsFromArray:events];
                    compBlock();
                });
        }    andError:^(NSError *error) {
             weakself.error = error;
        }];
    }else{
        self.checkString = string;
        [self.tempEvents removeAllObjects];
        [self.dataLoader exhibitionsFromServerWithSkipCountSortStringAndCallback:skip andSortString:string
                                                                       andResult:^(NSArray<Event *> *events) {
                                                                           dispatch_barrier_async(self.concurrentExhibitionsQueue, ^{
                                                                               [weakself.tempEvents addObjectsFromArray:events];
                                                                               compBlock();
                                                                           });
                                                                       }    andError:^(NSError *error) {
                                                                           weakself.error = error;
                                                                       }];

    }
}



- (void) loadExhibitionDescription:(Exhibition*) exhibition withCompletionBlock:(completionBlock)compBlock{
    __weak typeof(self) weakself = self;
    [self.dataLoader exhibitionDescriptionFromServerWithCallback:exhibition
                                                        andError:^(NSError *error) {
                                                           weakself.error = error;
                                                       }
                                              andCompletionBlock:^{
                                                            compBlock();
                                                        }];
    
}

- (NSArray<Event *> *) events{
    __weak typeof(self) weakself = self;
    __block NSArray *array;
    dispatch_sync(weakself.concurrentExhibitionsQueue, ^{
        array = weakself.tempEvents;
    });
    return array;
}






@end

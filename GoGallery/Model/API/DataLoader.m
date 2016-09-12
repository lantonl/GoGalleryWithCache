//
//  DataLoader.m
//  GoGallery
//
//  Created by Kirill Kirikov on 8/19/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "DataLoader.h"
#import "Exhibition.h"
#import "Artwork.h"
#import "Gallery.h"
#import "NSString+DateConvertor.h"

static NSString *kRawGalleryListBaseURL        = @"https://gallery-guru-prod.herokuapp.com/exhibitions";

@implementation DataLoader



#pragma mark - Load exhibitions from server

- (void) exhibitionsFromServerWithSkipCountSortStringAndCallback:(NSUInteger) skipCount andSortString:(NSString *)string andResult:(resultBlock) resultCallback andError:(errorBlock) errorCallback {
    NSString* paramString = [NSString stringWithFormat:@"?skip=%ld",skipCount];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", kRawGalleryListBaseURL, string, paramString]];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:5.0];
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            errorCallback(error);
    }else{
        NSError* parseError = nil;
        NSArray* exhibitionsList = [self loadJSONFromData:data withError:&parseError];
        if (parseError != nil){
                    NSLog(@"PARSE ERROR");
            errorCallback (parseError);
        }else{
            NSMutableArray* exhibitions = [[NSMutableArray alloc]init];
            for (NSDictionary *exhibitionDictionary in exhibitionsList) {
                Exhibition *exhibition = [[Exhibition alloc] initWithDictionary:exhibitionDictionary];
                NSDictionary *galleryDict = [[NSDictionary alloc]initWithDictionary:exhibitionDictionary[@"gallery"]];
                Gallery *gallery = [[Gallery alloc] initWithDictionary:galleryDict];
                NSDictionary *galleryLogo = [[NSDictionary alloc] initWithDictionary:galleryDict[@"galleryLogo"]];
                if (galleryLogo[@"url"]){
                gallery.logo = [[NSURL alloc] initWithString:galleryLogo[@"url"]];
                }else{
                    gallery.logo = [[NSURL alloc] initWithString:@""];
                }
                exhibition.gallery = gallery;
                if ([exhibitionDictionary[@"dateStart"] isKindOfClass:[NSDictionary class]]){
                    NSDictionary  *dateStartDict = [[NSDictionary alloc]initWithDictionary:exhibitionDictionary[@"dateStart"]];
                if ([dateStartDict[@"iso"] isKindOfClass:[NSMutableString class]]) {
                    exhibition.dateStart = [dateStartDict[@"iso"] date];
                }
                }
                
                if ([exhibitionDictionary[@"dateEnd"] isKindOfClass:[NSDictionary class]]){
                    NSDictionary  *dateEndDict = [[NSDictionary alloc]initWithDictionary: exhibitionDictionary[@"dateEnd"]];
                if ([dateEndDict[@"iso"] isKindOfClass:[NSMutableString class]]) {
                    exhibition.dateEnd = [dateEndDict[@"iso"] date];
                }
                }
                [exhibitions addObject:exhibition];
                
            }
            resultCallback (exhibitions);
        }
    }
    }];
    [task resume];
}

- (void) exhibitionDescriptionFromServerWithCallback:(Exhibition*) exhibition andError:(errorBlock) errorCallback andCompletionBlock:(completionBlock)compBlock;{
    NSString *ID = exhibition.ID;
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", kRawGalleryListBaseURL, ID]];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:5.0];
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            errorCallback(error);
        }else{
            NSError* parseError = nil;
            NSDictionary* exhibitionDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

            if (parseError != nil){
                errorCallback (parseError);
            }else{
                NSArray *works = [[NSArray alloc] initWithArray:exhibitionDict[@"works"]];
                NSMutableArray* tempWorksArray = [[NSMutableArray alloc]init];
                for (NSDictionary *artworkDict in works){
                    Artwork *artwork = [[Artwork alloc] initWithDictionary:artworkDict];
                    NSDictionary *picture = [[NSDictionary alloc] initWithDictionary:artworkDict[@"imgPicture"]];

                    artwork.imgPicture = [[NSURL alloc] initWithString:picture[@"url"]];
                    [tempWorksArray addObject:artwork];
                }
                exhibition.artworks = [NSArray arrayWithArray:tempWorksArray];
                compBlock();
            }
        }
    }];
    [task resume];
}



- (NSArray *) loadJSONFromData:(NSData *)data withError:(NSError **)error {
    NSArray *raw = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    return raw;
    
}

@end

//
//  Instagram.h
//  FavoritePhotosChallenge
//
//  Created by May Yang on 11/7/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Photo : NSObject
@property NSData *instaDataImage;
@property BOOL isSelected;
@property NSMutableArray *selectedPhotoArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

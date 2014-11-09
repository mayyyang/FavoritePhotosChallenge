//
//  Instagram.m
//  FavoritePhotosChallenge
//
//  Created by May Yang on 11/7/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    NSDictionary *imagesDictionary = dictionary[@"images"];
    NSDictionary *standardResolutionDictionary = imagesDictionary[@"standard_resolution"];
    NSString *urlString = standardResolutionDictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    self.instaImage = [NSData dataWithContentsOfURL:url];

    return self;
}


@end

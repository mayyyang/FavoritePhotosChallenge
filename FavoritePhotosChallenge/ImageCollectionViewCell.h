//
//  ImageCollectionViewCell.h
//  FavoritePhotosChallenge
//
//  Created by May Yang on 11/7/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIImageView *favoritedImageView;
@property UIImage *instaImage;



@end

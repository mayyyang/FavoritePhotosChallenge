//
//  SelectedDataViewController.m
//  FavoritePhotosChallenge
//
//  Created by May Yang on 11/9/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import "SelectedDataViewController.h"
#import "Photo.h"
#import "ImageCollectionViewCell.h"

@interface SelectedDataViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SelectedDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView reloadData];
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"favoritesCell" forIndexPath:indexPath];
    NSData *imageData = self.favoritedPhotosArray[indexPath.item];
    cell.favoritedImageView.image = [UIImage imageWithData:imageData];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.favoritedPhotosArray.count;
}


@end

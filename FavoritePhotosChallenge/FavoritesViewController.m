//
//  FavoritesViewController.m
//  FavoritePhotosChallenge
//
//  Created by May Yang on 11/7/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import "FavoritesViewController.h"
#import "SelectedImageCollectionViewCell.h"

@interface FavoritesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation FavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"favoriteCell" forIndexPath:indexPath];

    NSDictionary *metaDictionary = self.photoArray[indexPath.row];
    NSDictionary *images = [metaDictionary objectForKey:@"images"];
    NSDictionary *standardRes = [images objectForKey:@"standard_resolution"];
    NSString *urlJPG = [standardRes objectForKey:@"url"];



    NSURL *url = [NSURL URLWithString:urlJPG];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        cell.selectedImageView.image = [UIImage imageWithData:data];
    }];


    return cell;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

@end

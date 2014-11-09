//
//  SelectedDataViewController.m
//  FavoritePhotosChallenge
//
//  Created by May Yang on 11/9/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import "SelectedDataViewController.h"
#import "Photo.h"

@interface SelectedDataViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation SelectedDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return nil;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}


@end

//
//  ViewController.m
//  FavoritePhotosChallenge
//
//  Created by May Yang on 11/6/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "Photo.h"
#import "SelectedDataViewController.h"
#define kURL @"https://api.instagram.com/v1/media/popular?client_id=b7cbf00db1e143e9b84a787ed2c70f78"
#define kURLSearchTag @"https://api.instagram.com/v1/tags/%@/media/recent?client_id=b7cbf00db1e143e9b84a787ed2c70f78"

@interface ViewController () <UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property NSArray *data;
@property NSMutableArray *allSearchPhotosArray;
@property NSMutableArray *favoritedPhotosArray;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad
    {
    [super viewDidLoad];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [self initialLoadJSONData];

    }


#pragma mark = UICollectionViewDelegate methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"instaCell" forIndexPath:indexPath];

    if ([self.searchTextField.text isEqualToString:@""])
    {
        NSDictionary *metaDictionary = self.data[indexPath.row];
        NSDictionary *images = [metaDictionary objectForKey:@"images"];
        NSDictionary *standardRes = [images objectForKey:@"standard_resolution"];
        NSString *urlJPG = [standardRes objectForKey:@"url"];
        NSURL *url = [NSURL URLWithString:urlJPG];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            cell.imageView.image = [UIImage imageWithData:data];
        }];

    }

    else
    {
        Photo *instagramPhoto = self.allSearchPhotosArray[indexPath.item];
        cell.imageView.image = [UIImage imageWithData:instagramPhoto.instaDataImage];
    }


    return cell;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
//    return self.data.count;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}


#pragma mark = UITextFieldDelegate method for search

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![self.searchTextField.text isEqualToString:@""])
    {
        NSString *searchString = [NSString stringWithFormat:kURLSearchTag, self.searchTextField.text];

        [self tagSearchJSONData:searchString];

        [self.searchTextField resignFirstResponder];

    }
    return YES;
}

#pragma mark - Favorite Buttons

- (IBAction)onFavoriteButtonPressed:(Photo *)selectedPhoto
{
    //Add photo to favorites button
    NSLog(@"PHOTO ADDED TO FAVORITES");
    self.favoritedPhotosArray = [NSMutableArray new];
    [self.favoritedPhotosArray addObject:selectedPhoto];

    SelectedDataViewController *sdvc = [[SelectedDataViewController alloc]init];
    sdvc.favoritedPhotosArray = self.favoritedPhotosArray;


}

- (IBAction)viewFavoritesButtonPressed:(UIButton *)sender
{
    NSLog(@"Favorites button pressed");
    SelectedDataViewController *sdvc = [[SelectedDataViewController alloc]init];
    sdvc.favoritedPhotosArray = self.favoritedPhotosArray;

//    [self performSegueWithIdentifier:@"segue" sender:sender];
}



#pragma mark = Network calls

-(void)initialLoadJSONData
{
    NSURL *url = [NSURL URLWithString:kURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            NSLog(@"Yo you have an error: %@", connectionError.localizedDescription);
        }
        else
        {
            NSDictionary *APIResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.data = [APIResult objectForKey:@"data"];

            [self.collectionView reloadData];

        }
    }];
}

-(void)tagSearchJSONData:(NSString *)urlString
{
    self.allSearchPhotosArray = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (connectionError)
         {
             NSLog(@"Yo you have an error: %@", connectionError.localizedDescription);
         }
         else
         {
             NSDictionary *APIResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             self.data = [APIResult objectForKey:@"data"];

             for (NSDictionary *photoDictionary in self.data)
             {
                 Photo *instagramPhoto = [[Photo alloc]initWithDictionary:photoDictionary];
                 [self.allSearchPhotosArray addObject:instagramPhoto];
             }
             
             [self.collectionView reloadData];

         }

     }];

}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    SelectedDataViewController *selectedVC = segue.destinationViewController;
//    selectedVC.favoritedPhotosArray = self.favoritedPhotosArray;
//}

@end

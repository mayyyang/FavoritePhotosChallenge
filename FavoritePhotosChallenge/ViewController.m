//
//  ViewController.m
//  FavoritePhotosChallenge
//
//  Created by May Yang on 11/6/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "FavoritesViewController.h"
#import "Photo.h"
#define kURL @"https://api.instagram.com/v1/media/popular?client_id=b7cbf00db1e143e9b84a787ed2c70f78"

@interface ViewController () <UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property NSArray *data;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
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

            //            NSDictionary *metaDictionary = self.data;
            //            NSDictionary *images = [metaDictionary objectForKey:@"images"];
            
        }

    }];

    

}



//- (void)loadInstagramPhotos
//{
//    NSDictionary *metaDictionary = self.data;
//
//}

#pragma mark = UICollectionViewDelegate methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"instaCell" forIndexPath:indexPath];
    NSDictionary *metaDictionary = self.data[indexPath.row];
    NSDictionary *images = [metaDictionary objectForKey:@"images"];
    NSDictionary *standardRes = [images objectForKey:@"standard_resolution"];
    NSString *urlJPG = [standardRes objectForKey:@"url"];



    NSURL *url = [NSURL URLWithString:urlJPG];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        cell.imageView.image = [UIImage imageWithData:data];
    }];


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


#pragma mark = UITextFieldDelegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![self.searchTextField.text isEqualToString:@""])
    {
        NSString *searchString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=b7cbf00db1e143e9b84a787ed2c70f78", self.searchTextField.text];
         [self.searchTextField resignFirstResponder];
        NSURL *url = [NSURL URLWithString:searchString];


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

                //            NSDictionary *metaDictionary = self.data;
                //            NSDictionary *images = [metaDictionary objectForKey:@"images"];
                
            }
            
        }];

    }
    return YES;
}

-(void)dataWithURLString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            [self networkAlertWindow:connectionError.localizedDescription];
        }
    }];
}

-(void)networkAlertWindow:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network error" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Gosh Darnit" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    FavoritesViewController *favoritesVC = segue.destinationViewController;
//    favoritesVC.photoArray = self.data;
//    
//}

@end

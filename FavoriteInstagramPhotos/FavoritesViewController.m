//
//  SecondViewController.m
//  FavoriteInstagramPhotos
//
//  Created by Jonathan Kim on 11/8/14.
//  Copyright (c) 2014 Jonathan Kim. All rights reserved.
//

#import "FavoritesViewController.h"
#import "PhotosViewController.h"
#import "FavoritesCollectionViewCell.h"
#import "InstagramImage.h"
#import "PhotosCollectionViewCell.h"
#import "MapViewController.h"

#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>

@interface FavoritesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property FavoritesCollectionViewCell *favoriteCell;

@end

@implementation FavoritesViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.favoritesArray = [@[] mutableCopy];

    [self.collectionView reloadData];

    PhotosViewController *photoVC = self.tabBarController.viewControllers[0];

    [self.favoritesArray addObjectsFromArray:photoVC.favoritesArray];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isDeleted = NO;
}

#pragma mark - Alert functionality in didSelectItemAtIndexPath Method

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Menu" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *deleteButton = [UIAlertAction actionWithTitle:@"DELETE" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

        // Below code removes data from first VC's array

        PhotosViewController *photoVC = self.tabBarController.viewControllers[0];
        [photoVC.favoritesArray removeObjectAtIndex:indexPath.item];

        InstagramImage *InstaPhoto = self.favoritesArray[indexPath.item];
        InstaPhoto.isSelected = NO;

        [self.favoritesArray removeObjectAtIndex:indexPath.item];
        [self.collectionView reloadData];

        // BOOL to check is photo is deleted
        self.isDeleted = YES;

    }];
    UIAlertAction *keepButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

    //Add Twitter use

    UIAlertAction *tweetButton = [UIAlertAction actionWithTitle:@"TWEET!"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action)
                                  {
                                      SLComposeViewController *tweet = [SLComposeViewController
                                                                             composeViewControllerForServiceType:SLServiceTypeTwitter];
                                      [tweet setInitialText:@"Sharing this awesome shot!"];

                                      InstagramImage *twitterImage = self.favoritesArray[indexPath.item];
                                      [tweet addImage:twitterImage.instagramImage];

                                      [self presentViewController:tweet animated:YES completion:nil];

                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                      
                                  }];

/* ---------------------Email function VERY BUGGY----------------*/

    UIAlertAction *emailButton = [UIAlertAction actionWithTitle:@"E-mail" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
        email.delegate = self;

//        InstagramImage *instagramPhoto = self.favoritesArray[indexPath.item];
//        UIImage *emailImage = instagramPhoto.instagramImage;

        // convert the image into data
//        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(emailImage)];

        [email setSubject:@"Loving this snapshot"];
        [email setToRecipients:[NSArray arrayWithObject:@"jonnokim17@gmail.com"]];
        [email setMessageBody:@"What do you think about this pic??" isHTML:NO];
//        [email addAttachmentData:imageData mimeType:@"png" fileName:@"Liked Picture"];

        [self presentViewController:email animated:YES completion:nil];

    }];

    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:deleteButton];
    [alert addAction:keepButton];
    [alert addAction:tweetButton];
    [alert addAction:emailButton];
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.favoritesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     self.favoriteCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"favoritesCell" forIndexPath:indexPath];

    InstagramImage *instagramImage = self.favoritesArray[indexPath.item];

    self.favoriteCell.imageView.image = instagramImage.instagramImage;

    return self.favoriteCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndexPath = [self.collectionView indexPathForCell:self.favoriteCell];
    InstagramImage *instagramImage = self.favoritesArray[selectedIndexPath.item];

    MapViewController *mapVC = segue.destinationViewController;

        if (instagramImage.coordinate.longitude != 0) {
            mapVC.coordinate = instagramImage.coordinate;
            mapVC.user = instagramImage.user;
            mapVC.username = instagramImage.username;
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"SORRY" message:@"no location found!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
            [alert addAction:okButton];
    
            [self presentViewController:alert animated:YES completion:nil];
        }
}



@end

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

@interface FavoritesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *favoritesArray;

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

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.favoritesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FavoritesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"favoritesCell" forIndexPath:indexPath];

    InstagramImage *instagramImage = self.favoritesArray[indexPath.item];

    cell.imageView.image = instagramImage.instagramImage;

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}

@end

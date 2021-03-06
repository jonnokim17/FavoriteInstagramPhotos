//
//  FirstViewController.m
//  FavoriteInstagramPhotos
//
//  Created by Jonathan Kim on 11/8/14.
//  Copyright (c) 2014 Jonathan Kim. All rights reserved.
//

#define kJSONURL @"https://api.instagram.com/v1/tags/lakers/media/recent?count=10&client_id=7546270fb62443c897938bdd6bed27bf"
#define kSearchJSON @"https://api.instagram.com/v1/tags/%@/media/recent?count=10&client_id=7546270fb62443c897938bdd6bed27bf"

#import "PhotosViewController.h"
#import "InstagramImage.h"
#import "PhotosCollectionViewCell.h"

@interface PhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@end

@implementation PhotosViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.collectionView reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.favoritesArray = [@[] mutableCopy];

    [self getJSONDataFromURL:kJSONURL];

}

#pragma Helper Methods

// Getting JSON Data via Model

- (void)getJSONDataFromURL:(NSString *)urlString
{
    self.dataArray = [@[] mutableCopy];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Error: %@", connectionError.localizedDescription);
        }
        else
        {
            NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *dataArray = JSONDictionary[@"data"];

            for (NSDictionary *dict in dataArray)
            {
                // get only 10 pictures
                if (self.dataArray.count <= 10)
                {
                    InstagramImage *instagramImage = [[InstagramImage alloc] initWithDictionary:dict];
                    [self.dataArray addObject:instagramImage];
                }
            }
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - Helper Method

- (void)checkForFavoritedPhoto:(InstagramImage *)photo
{
    BOOL favoritedPhoto = NO;

    InstagramImage *instaImage;

    for (instaImage in self.favoritesArray)
    {
        if (photo.photoID == instaImage.photoID)
        {
            favoritedPhoto = YES;
        }
    }

    if (favoritedPhoto == NO && !instaImage.isSelected)
    {
        [self.favoritesArray addObject:photo];
    }
    else
    {
        [self.favoritesArray removeObject:photo];
    }

    [self.collectionView reloadData];
    [self save];
}



#pragma mark - Searchbar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (![searchBar.text isEqualToString:@""]) {
        self.dataArray = [@[] mutableCopy];

        NSString *searchString = [NSString stringWithFormat:kSearchJSON, searchBar.text];
        [self getJSONDataFromURL:searchString];

        [searchBar resignFirstResponder];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}


#pragma mark - CollectionView Delegate Methods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    InstagramImage *instagramImage = self.dataArray[indexPath.item];

    cell.imageView.image = instagramImage.instagramImage;

    if (!instagramImage.isSelected)
    {
        cell.likedImage.image = [UIImage imageNamed:@"heart"];
    }
    else
    {
        cell.likedImage.image = [UIImage imageNamed:@"heart_full"];

    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    InstagramImage *instaImage = self.dataArray[indexPath.item];

    instaImage.isSelected = !instaImage.isSelected;

    [self checkForFavoritedPhoto:instaImage];
}

#pragma mark SAVE/LOAD METHODS

// Not working...

- (void)save
{
    NSURL *plistURL = [[self documentsDirectoryURL]URLByAppendingPathComponent:@"favorites.plist"];
    [self.favoritesArray writeToURL:plistURL atomically:YES];
}

- (void)load
{
    NSURL *plistURL = [[self documentsDirectoryURL]URLByAppendingPathComponent:@"favorites.plist"];
    self.favoritesArray = [NSMutableArray arrayWithContentsOfURL:plistURL];

    if (self.favoritesArray == nil)
    {
        self.favoritesArray = [@[]mutableCopy];
    }
}

- (NSURL*)documentsDirectoryURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    return url;
}

@end

//
//  SecondViewController.h
//  FavoriteInstagramPhotos
//
//  Created by Jonathan Kim on 11/8/14.
//  Copyright (c) 2014 Jonathan Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController

@property BOOL isDeleted;
@property (strong, nonatomic) NSMutableArray *favoritesArray;

@end


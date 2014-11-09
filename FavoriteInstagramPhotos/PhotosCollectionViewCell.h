//
//  PhotosCollectionViewCell.h
//  FavoriteInstagramPhotos
//
//  Created by Jonathan Kim on 11/8/14.
//  Copyright (c) 2014 Jonathan Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *likedImage;

@end

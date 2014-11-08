//
//  InstagramImage.h
//  FavoriteInstagramPhotos
//
//  Created by Jonathan Kim on 11/8/14.
//  Copyright (c) 2014 Jonathan Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InstagramImage : NSObject

@property (strong, nonatomic) UIImage *instagramImage;
@property (strong, nonatomic) NSString *photoID;

- (instancetype)initWithDictionary:(NSDictionary *)photoDictionary;

@end

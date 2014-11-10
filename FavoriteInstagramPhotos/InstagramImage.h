//
//  InstagramImage.h
//  FavoriteInstagramPhotos
//
//  Created by Jonathan Kim on 11/8/14.
//  Copyright (c) 2014 Jonathan Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface InstagramImage : NSObject

@property (strong, nonatomic) UIImage *instagramImage;
@property BOOL isSelected;
@property (strong, nonatomic) NSString *photoID;
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *username;

//@property (strong, nonatomic) NSNumber *latitude;
//@property (strong, nonatomic) NSNumber *longitude;

@property (readonly) CLLocationCoordinate2D coordinate;

- (instancetype)initWithDictionary:(NSDictionary *)photoDictionary;

@end

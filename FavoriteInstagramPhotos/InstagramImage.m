//
//  InstagramImage.m
//  FavoriteInstagramPhotos
//
//  Created by Jonathan Kim on 11/8/14.
//  Copyright (c) 2014 Jonathan Kim. All rights reserved.
//

#import "InstagramImage.h"

@implementation InstagramImage
{
    NSDictionary *localDictionary;
}


- (instancetype)initWithDictionary:(NSDictionary *)photoDictionary
{
    self = [super init];

    localDictionary = photoDictionary;

    self.photoID = photoDictionary[@"id"];

    NSURL *url = [NSURL URLWithString:photoDictionary[@"images"][@"standard_resolution"][@"url"]];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.instagramImage = [UIImage imageWithData:urlData];

    // check to see if photo has been selected
    self.isSelected = NO;

    // coordinate for mapVC
//    CLLocationCoordinate2D coord;
//
//    if ([photoDictionary[@"location"] isEqual: @"null"]) {
//        NSLog(@"sorry");
//    }
//    else
//    {
//        coord.latitude = [photoDictionary[@"location"][@"latitude"] doubleValue];
//        coord.longitude = [photoDictionary[@"location"][@"longitude"] doubleValue];
//    }
//
//    self.coordinate = coord;

    return self;
}

 //Coordinates for MapView

-(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coord;

    if ([localDictionary[@"location"] isKindOfClass:[NSDictionary class]])
    {
        coord.latitude = [localDictionary[@"location"][@"latitude"] floatValue];
        coord.longitude = [localDictionary[@"location"][@"longitude"] floatValue];
    }
    return coord;
}

@end

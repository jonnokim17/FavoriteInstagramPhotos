//
//  InstagramImage.m
//  FavoriteInstagramPhotos
//
//  Created by Jonathan Kim on 11/8/14.
//  Copyright (c) 2014 Jonathan Kim. All rights reserved.
//

#import "InstagramImage.h"

@implementation InstagramImage


- (instancetype)initWithDictionary:(NSDictionary *)photoDictionary
{
    self = [super init];

    NSURL *url = [NSURL URLWithString:photoDictionary[@"images"][@"standard_resolution"][@"url"]];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.instagramImage = [UIImage imageWithData:urlData];

    self.isSelected = NO;

    return self;
}

@end

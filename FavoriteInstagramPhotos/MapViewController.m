//
//  MapViewController.m
//  FavoriteInstagramPhotos
//
//  Created by Jonathan Kim on 11/9/14.
//  Copyright (c) 2014 Jonathan Kim. All rights reserved.
//

#import "MapViewController.h"
#import "FavoritesViewController.h"
#import "InstagramImage.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSMutableArray *mapArray;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapArray = [@[] mutableCopy];

    FavoritesViewController *favoritesVC = self.tabBarController.viewControllers[1];
    [self.mapArray addObjectsFromArray:favoritesVC.favoritesArray];

    NSLog(@"%lu", (unsigned long)self.mapArray.count);

    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];

    InstagramImage *instagramImage = self.mapArray.firstObject;

    annotation.coordinate = instagramImage.coordinate;

    [self.mapView addAnnotation:annotation];

    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;

    MKCoordinateRegion region;
    region.center = instagramImage.coordinate;
    region.span = span;

    [self.mapView setRegion:region animated:YES];
}

#pragma mark - MKMapView Delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{

    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    return pin;
}




@end

//
//  ViewController.m
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+UIColorCategory.h"
#import "MapAnnotation.h"
#import "LocationController.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpMapView];
    
    [self setUpToolBar];
    
    [self setUpSearchBar];
    
    [self settingAnnotations];
    
}

- (void)setUpMapView {
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 75)];
    self.mapView.delegate = self;
    [self.mapView setMapType:MKMapTypeHybrid];
    [self.view addSubview:self.mapView];
    
    UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:pressRecognizer];
    
}

- (void)setUpToolBar {
    
    self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 75, self.view.frame.size.width, 75)];
    self.toolBar.backgroundColor = [UIColor backgroundColor];
    [self.view addSubview:self.toolBar];
    
    UIImage *photo = [UIImage imageNamed:@"search"];
    UIImage *share = [UIImage imageNamed:@"share"];
    
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithImage:photo style:UIBarButtonItemStylePlain target:self action:@selector(popSearchBar:)];
    [buttons addObject:searchButton];
    
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithImage:share style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonPressed:)];
    [buttons addObject:shareButton];
    
    [self.toolBar setItems:buttons];
}

- (void)setUpSearchBar {
    
    self.searchBar = [[SearchBarView alloc] initWithFrame:CGRectMake(0, -80, self.view.frame.size.width, 80)];
    [self.view addSubview:self.searchBar];
    
}

-(void)popSearchBar:(id)sender {
    
    [self popSearchBar:self.searchBar distance:self.searchBar.frame.size.height withDuration:1.0];
    [self.searchBar resignFirstResponder];
    
}

- (void)popSearchBar:(UIView *)view distance:(float)distance withDuration:(float)duration {
    
    [UIView animateWithDuration:1.0 animations:^{
        
        view.center = CGPointMake(view.center.x, view.center.y + distance);
        
    }];

}


- (void)shareButtonPressed:(id)sender {
    
    NSString *string = @"";
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:@[string] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}

- (void)handleLongPressGesture:(UIGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self.mapView removeGestureRecognizer:sender];
    }
    else {
        
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        
        MapAnnotation *dropPin = [[MapAnnotation alloc] initWithLocation:locCoord];
        
        NSString *latitude = [NSString stringWithFormat:@"%f", dropPin.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f", dropPin.coordinate.longitude];
        
        [[LocationController sharedInstance] addLocationWithLatitude:latitude longitude:longitude];
        
        [self.mapView addAnnotation:dropPin];
        
    }
    
}

- (void)settingAnnotations {
    
    NSArray *locations = [LocationController sharedInstance].locations;
    
    for (Location *location in locations) {
        double latitudeDouble = [location.latitude doubleValue];
        double longitudeDouble = [location.longitude doubleValue];
        
        CLLocationCoordinate2D locCoord = CLLocationCoordinate2DMake(latitudeDouble, longitudeDouble);
        
        MapAnnotation *dropPin = [[MapAnnotation alloc] initWithLocation:locCoord];
        [self.mapView addAnnotation:dropPin];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

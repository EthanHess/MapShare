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


@interface ViewController () <UISearchBarDelegate>

@property (nonatomic, strong) id <MKAnnotation> selectedAnnotation;

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
    
    UIImage *boom = [UIImage imageNamed:@"boom"];
    UIImage *photo = [UIImage imageNamed:@"search"];
    UIImage *share = [UIImage imageNamed:@"share"];
    
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *flexItem0 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem0];
    
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc]initWithImage:boom style:UIBarButtonItemStylePlain target:self action:@selector(clearAll)];
    [buttons addObject:clearButton];
    
    UIBarButtonItem *flexItem1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem1];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithImage:photo style:UIBarButtonItemStylePlain target:self action:@selector(popSearchBar:)];
    [buttons addObject:searchButton];
    
    UIBarButtonItem *flexItem2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem2];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithImage:share style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonPressed:)];
    [buttons addObject:shareButton];
    
    UIBarButtonItem *flexItem3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem3];
    
    [self.toolBar setItems:buttons];
}

- (void)setUpSearchBar {
    
    self.searchBarView = [[SearchBarView alloc] initWithFrame:CGRectMake(0, -80, self.view.frame.size.width, 80)];
    [self.view addSubview:self.searchBarView];
    
    [self.searchBarView.button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)popSearchBar:(id)sender {
    
    if (self.searchBarView.frame.origin.y < 64) {
    
    [self popSearchBar:self.searchBarView distance:self.searchBarView.frame.size.height + 64 withDuration:0.5];
    [self.searchBarView resignFirstResponder];
        
    }
    else {
    
    [self popSearchBarBack:self.searchBarView distance:self.searchBarView.frame.size.height + 64 withDuration:0.5];
    [self.searchBarView resignFirstResponder];
        
    }
    
    
    
}

- (void)popSearchBar:(UIView *)view distance:(float)distance withDuration:(float)duration {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.center = CGPointMake(view.center.x, view.center.y + distance);
        
    }];

}

- (void)popSearchBarBack:(UIView *)view distance:(float)distance withDuration:(float)duration {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.center = CGPointMake(view.center.x, view.center.y - distance);
        
    }];
    
}


- (void)shareButtonPressed:(id)sender {
    
    NSString *string = @"";
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:@[string] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}

- (void)handleLongPressGesture:(UIGestureRecognizer *)sender {
    
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        [self.mapView removeGestureRecognizer:sender];
//    }
//    else {
    
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
        MapAnnotation *dropPin = [[MapAnnotation alloc] initWithLocation:locCoord];
        
        NSString *latitude = [NSString stringWithFormat:@"%f", dropPin.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f", dropPin.coordinate.longitude];
        
        [[LocationController sharedInstance] addLocationWithLatitude:latitude longitude:longitude];
        
        [self.mapView addAnnotation:dropPin];
        
//    }
    
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

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    self.calloutView.annotation = view.annotation;

    self.calloutView = [[CalloutView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - self.calloutView.frame.size.width/2, self.view.frame.size.height/2 - self.calloutView.frame.size.height/2, 80, 100)];
    
    [self.calloutView.removeButton addTarget:self action:@selector(removeLocation) forControlEvents:UIControlEventTouchUpInside];
    self.selectedAnnotation = view.annotation;
    [self.calloutView setHidden:NO];
    [self.mapView addSubview:self.calloutView];
    
}

- (void)search {
    
    NSString *searchText = self.searchBarView.searchBar.text;
    
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:[NSString stringWithFormat:@"%@", searchText]];
    
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            for (MKMapItem *mapItem in [response mapItems]) {
                NSLog(@"Name: %@, Placemark title: %@", [mapItem name], [[mapItem placemark] title]);
            }
        } else {
            NSLog(@"Search Request Error: %@", [error localizedDescription]);
        }
    }];


}


- (void)removeLocation {
    
    NSString *lat = [NSString stringWithFormat:@"%f", [self.selectedAnnotation coordinate].latitude];
    NSString *lon = [NSString stringWithFormat:@"%f", [self.selectedAnnotation coordinate].longitude];
    
    
    for (Location *location in [LocationController sharedInstance].locations) {
        
        if ([location.latitude isEqualToString:lat] && [location.longitude isEqualToString:lon]) {
            
            [[LocationController sharedInstance]removeLocation:location];
            
            [self.mapView removeAnnotation:self.selectedAnnotation];
            
            [self.mapView reloadInputViews];
            
        }
        
    }

    
    [self.calloutView setHidden:YES];
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    
    
    
    
}


- (void)clearAll {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Delete All Annotations?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert show];
    
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//
//    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"MyPin"];
//    if (!annotationView) {
//        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyPin"];
//        annotationView.canShowCallout = YES;
//        annotationView.animatesDrop = YES;
//    }
//
//    annotationView.annotation = annotation;
//
//    return annotationView;
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

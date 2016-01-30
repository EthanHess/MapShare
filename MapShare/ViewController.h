//
//  ViewController.h
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBarView.h"
@import MapKit;
#import "Location.h"
#import "CalloutView.h"

@interface ViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) SearchBarView *searchBarView;
@property (nonatomic, strong) CalloutView *calloutView;
//@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) NSArray *resultPlaces;
@property (nonatomic, strong) UIToolbar *navToolBar;


@end


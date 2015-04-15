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
#import "SoundController.h"
#import "DismissView.h"

#define METERS_PER_MILE 23609.344

@interface ViewController () <UISearchBarDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id <MKAnnotation> selectedAnnotation;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SoundController *soundController;
@property (nonatomic, strong) DismissView *dismissView;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, readonly) MKMapType *currentMapType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.soundController = [SoundController new];
    
    [self setUpMapView];
    
    [self setUpToolBar];
    
    [self setUpSearchBar];
    
    [self settingAnnotations];
    
    [self setUpDismissView];
    
    [self setUpTableView];

}


- (void)setUpMapView {
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 75)];
    self.mapView.delegate = self;
    [self.mapView setMapType:MKMapTypeHybrid];
    [self.view addSubview:self.mapView];
    
    UITapGestureRecognizer *pressRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapPressGesture:)];
    [self.mapView addGestureRecognizer:pressRecognizer];


    
}

- (void)setUpToolBar {
    
    self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 75, self.view.frame.size.width, 75)];
//    self.toolBar.backgroundColor = [UIColor toolbarBackground];
    [self.toolBar setBackgroundImage:[UIImage imageNamed:@"yellow"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
//    self.toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dirt"]];
    [self.view addSubview:self.toolBar];
    
    UIImage *map = [UIImage imageNamed:@"map"];
    UIImage *boom = [UIImage imageNamed:@"boom"];
    UIImage *photo = [UIImage imageNamed:@"search"];
    UIImage *share = [UIImage imageNamed:@"share"];
    
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *flexItem0 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem0];
    
    UIBarButtonItem *mapType = [[UIBarButtonItem alloc]initWithImage:map style:UIBarButtonItemStylePlain target:self action:@selector(mapType)];
    [buttons addObject:mapType];
    
    UIBarButtonItem *flexItem1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem1];
    
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc]initWithImage:boom style:UIBarButtonItemStylePlain target:self action:@selector(clearAll)];
    [buttons addObject:clearButton];
    
    UIBarButtonItem *flexItem2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem2];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithImage:photo style:UIBarButtonItemStylePlain target:self action:@selector(popSearchBar:)];
    [buttons addObject:searchButton];
    
    UIBarButtonItem *flexItem3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem3];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithImage:share style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonPressed:)];
    [buttons addObject:shareButton];
    
    UIBarButtonItem *flexItem4 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem4];
    
    [self.toolBar setItems:buttons];
}

- (void)mapType {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Map Type" message:@"Choose Style" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Hybrid" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.mapView setMapType:MKMapTypeHybrid];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Satellite" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.mapView setMapType:MKMapTypeSatellite];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Standard" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.mapView setMapType:MKMapTypeStandard];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:alertController completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)setUpSearchBar {
    
    self.searchBarView = [[SearchBarView alloc] initWithFrame:CGRectMake(0, -80, self.view.frame.size.width, 80)];
    [self.view addSubview:self.searchBarView];
    
    [self.searchBarView.button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)popSearchBar:(id)sender {
    
    if (self.searchBarView.frame.origin.y < 64) {
    
    [self popSearchBar:self.searchBarView distance:self.searchBarView.frame.size.height + 64];
    [self.searchBarView resignFirstResponder];
        
    }
    else {
    
    [self popSearchBarBack:self.searchBarView distance:self.searchBarView.frame.size.height + 64];
    [self.searchBarView resignFirstResponder];
        
    }
    
    
    
}

- (void)popSearchBar:(UIView *)view distance:(float)distance {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.center = CGPointMake(view.center.x, view.center.y + distance);
        
    }];

}

- (void)popSearchBarBack:(UIView *)view distance:(float)distance {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.center = CGPointMake(view.center.x, view.center.y - distance);
        
    }];
    
}



- (void)handleTapPressGesture:(UIGestureRecognizer *)sender {
    
    
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
        MapAnnotation *dropPin = [[MapAnnotation alloc] initWithLocation:locCoord];
    
        NSString *latitude = [NSString stringWithFormat:@"%f", dropPin.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f", dropPin.coordinate.longitude];
        
        [[LocationController sharedInstance] addLocationWithLatitude:latitude longitude:longitude];
        
        [self.mapView addAnnotation:dropPin];
        [self playClongSound];
    

    

}

- (void)playClongSound {
    
    NSURL *urlForClong = [[NSBundle mainBundle] URLForResource:@"clong-1" withExtension:@"mp3"];
    
    [self.soundController playAudioFileAtURL:urlForClong];
    
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

- (void)setUpDismissView {
    
    self.dismissView = [[DismissView alloc]initWithFrame:CGRectMake(80, 170, self.view.frame.size.width - 160, 70)];
    [self.dismissView.dismissButton addTarget:self action:@selector(dismissTableView) forControlEvents:UIControlEventTouchUpInside];
    [self.dismissView setHidden:YES];
    [self.view addSubview:self.dismissView];
    
}

- (void)dismissTableView {
    

    [self.tableView removeFromSuperview];
    [self.dismissView setHidden:YES];
}

- (void)search {
    
    NSString *searchText = self.searchBarView.searchBar.text;
    
    if ([searchText isEqual: @""]) {
        return;
    }
    
    else {
    
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:[NSString stringWithFormat:@"%@", searchText]];
    
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            self.resultPlaces = [response mapItems];
            [self setUpTableView];
            [self.dismissView setHidden:NO];
            [self.tableView reloadData];
        } else {
            NSLog(@"Search Request Error: %@", [error localizedDescription]);
        }
    }];
    
    
    }

}



- (void)setUpTableView {
    
    [self.tableView removeFromSuperview];
    
    CGFloat tableViewHeight;
    
    if (self.resultPlaces.count < 5) {
        tableViewHeight = 80 * self.resultPlaces.count;
    }
    else
    {
        tableViewHeight = 80 * 4;
    }
    
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(80, 240, self.view.frame.size.width - 160, tableViewHeight)];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self registerTableView:self.tableView];
    

    [self.view addSubview:self.tableView];
    
}

- (void)registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"]; 
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    cell.backgroundColor = [UIColor lightBlueColor];
    
    MKMapItem *item = self.resultPlaces[indexPath.row];
    
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluePool"]];
    cell.textLabel.text = item.name;
    cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:18];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor clearColor]; 
    cell.detailTextLabel.text = item.placemark.title;
    cell.detailTextLabel.font = [UIFont fontWithName:@"Chalkduster" size:14];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.resultPlaces.count;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MKMapItem *zoomItem = self.resultPlaces[indexPath.row];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([zoomItem placemark].coordinate, 0.1*METERS_PER_MILE, 0.1*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80; 
}

- (void)removeLocation {
    
    NSString *lat = [NSString stringWithFormat:@"%f", [self.selectedAnnotation coordinate].latitude];
    NSString *lon = [NSString stringWithFormat:@"%f", [self.selectedAnnotation coordinate].longitude];
    
    
    for (Location *location in [LocationController sharedInstance].locations) {
        
        if ([location.latitude isEqualToString:lat] && [location.longitude isEqualToString:lon]) {
            
            [[LocationController sharedInstance]removeLocation:location];
            
            [self.mapView removeAnnotation:self.selectedAnnotation];
            
        }
        
    }

    [self.calloutView setHidden:YES];
    [self playWaterSplashSound];
    
}



- (void)clearAll {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Delete All Annotations?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (buttonIndex == 1) {
        
        for (Location *location in [LocationController sharedInstance].locations) {
            
            [[LocationController sharedInstance] removeLocation:location];
            
        }
        
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self playBombSound];
        
    }
}

- (void)playWaterSplashSound {
    
    NSURL *urlForWater = [[NSBundle mainBundle] URLForResource:@"water-splash-3" withExtension:@"mp3"];
    
    [self.soundController playAudioFileAtURL:urlForWater];
    
}

- (void)playBombSound {
    
    NSURL *urlForBomb = [[NSBundle mainBundle] URLForResource:@"bomb" withExtension:@"mp3"];
    
    [self.soundController playAudioFileAtURL:urlForBomb];
    
}

- (void)snapshotMapImage:(void (^)(UIImage *image))completion {
    
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.region = self.mapView.region;
    options.scale = [UIScreen mainScreen].scale;
    options.size = self.mapView.frame.size;
    options.mapType = MKMapTypeHybrid;
    options.showsPointsOfInterest = YES;
    
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        completion(snapshot.image);
    }];

}

- (void)shareButtonPressed:(id)sender {
    
    [self snapshotMapImage:^(UIImage *image) {
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:@[image] applicationActivities:nil];
        [self presentViewController:activityViewController animated:YES completion:nil];

    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

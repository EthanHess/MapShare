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
#import "OnBoardMainView.h"
#import "SnapshotController.h"
#import "SnapshotCollectionView.h"

#define METERS_PER_MILE 23609.344

@interface ViewController () <UISearchBarDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id <MKAnnotation> selectedAnnotation;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SoundController *soundController;
@property (nonatomic, strong) DismissView *dismissView;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, readonly) MKMapType *currentMapType;
@property (nonatomic, strong) MKPinAnnotationView *pinAnnotation;


@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [[self navigationController] setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.soundController = [SoundController new];
    
    [self setUpMapView];
    
    [self setUpToolBar];
    
    [self setUpNavigationToolBar];
    
    [self setUpSearchBar];
    
    [self settingAnnotations];
    
    [self setUpDismissView];
    
    [self setUpTableView];
    
    [self.view bringSubviewToFront:self.navToolBar]; 

}


- (void)setUpMapView {
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 75)];
    self.mapView.delegate = self;
    [self.mapView setMapType:MKMapTypeHybrid];
    [self.view addSubview:self.mapView];
    
    UITapGestureRecognizer *pressRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapPressGesture:)];
    [self.mapView addGestureRecognizer:pressRecognizer];


    
}

- (void)setUpNavigationToolBar {
    
    self.navToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    [self.navToolBar setBackgroundImage:[UIImage imageNamed:@"blackstone"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.navToolBar];
    
    UIImage *pencil = [UIImage imageNamed:@"pencil"];
    UIImage *question = [UIImage imageNamed:@"question"];
    UIImage *zoom = [UIImage imageNamed:@"zoomOut"];
    UIImage *archives = [UIImage imageNamed:@"archives"];
    
    NSMutableArray *navItems = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *flexItem0 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem0];
    
    UIBarButtonItem *pinColor = [[UIBarButtonItem alloc]initWithImage:pencil style:UIBarButtonItemStylePlain target:self action:@selector(changePinColor)];
    [navItems addObject:pinColor];
    
    UIBarButtonItem *flexItem1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem1];
    
    UIBarButtonItem *questionButton = [[UIBarButtonItem alloc]initWithImage:question style:UIBarButtonItemStylePlain target:self action:@selector(onboarding)];
    [navItems addObject:questionButton];
    
    UIBarButtonItem *flexItem2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem2];
    
    UIBarButtonItem *zoomOut = [[UIBarButtonItem alloc]initWithImage:zoom style:UIBarButtonItemStylePlain target:self action:@selector(zoomOut)];
    [navItems addObject:zoomOut];
    
    UIBarButtonItem *flexItem3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem3];
    
    UIBarButtonItem *archiveButton = [[UIBarButtonItem alloc]initWithImage:archives style:UIBarButtonItemStylePlain target:self action:@selector(archivesController)];
    [navItems addObject:archiveButton];
    
    UIBarButtonItem *flexItem4 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem4];

    [self.navToolBar setItems:navItems];
    
    
}

- (void)setUpToolBar {
    
    self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 75, self.view.frame.size.width, 75)];
    [self.toolBar setBackgroundImage:[UIImage imageNamed:@"yellow"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.toolBar];
    
    UIImage *map = [UIImage imageNamed:@"map"];
    UIImage *boom = [UIImage imageNamed:@"boom"];
    UIImage *search = [UIImage imageNamed:@"search"];
    UIImage *photo = [UIImage imageNamed:@"Photo"];
    
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
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithImage:search style:UIBarButtonItemStylePlain target:self action:@selector(popSearchBar:)];
    [buttons addObject:searchButton];
    
    UIBarButtonItem *flexItem3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem3];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithImage:photo style:UIBarButtonItemStylePlain target:self action:@selector(saveSnapshot)];
    [buttons addObject:shareButton];
    
    UIBarButtonItem *flexItem4 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem4];
    
    [self.toolBar setItems:buttons];
}

- (void)changePinColor {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pin Color" message:@"Pick a color!" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Red" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.pinAnnotation.pinColor = MKPinAnnotationColorRed;
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Green" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.pinAnnotation.pinColor = MKPinAnnotationColorGreen;
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Purple" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.pinAnnotation.pinColor = MKPinAnnotationColorPurple;
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:alertController completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)archivesController {
    
    SnapshotCollectionView *snapshotView = [SnapshotCollectionView new];
    
    [self.navigationController pushViewController:snapshotView animated:YES];
    
}

- (void)onboarding {
    
    OnBoardMainView *onboardMainView = [OnBoardMainView new];
    
    [self.navigationController pushViewController:onboardMainView animated:YES];
    
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar becomeFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
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
    
    if (self.searchBarView.frame.origin.y < 75) {
    
    [self popSearchBar:self.searchBarView distance:self.searchBarView.frame.size.height + 75];
    [self.searchBarView becomeFirstResponder];
        
    }
    else {
    
    [self popSearchBarBack:self.searchBarView distance:self.searchBarView.frame.size.height + 75];
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
            [self.searchBarView resignFirstResponder];
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
    
  
//    MKCoordinateRegion wholeWorld = MKCoordinateRegionForMapRect(MKMapRectWorld);

    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    
//    options.region = wholeWorld;
    
    options.region = self.mapView.region;
    
//    options.scale = [UIScreen mainScreen].scale;
//    options.size = self.mapView.frame.size;
    
    options.mapType = MKMapTypeHybrid;
    options.showsPointsOfInterest = YES;
    
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        completion(snapshot.image);
    }];

}

- (void)zoomOut {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (MapAnnotation *annotation in self.mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    
    [self.mapView setVisibleMapRect:zoomRect animated:YES];
    
}

- (void)saveSnapshot {
    
    [self snapshotMapImage:^(UIImage *image) {
        [self alertView];
        [[SnapshotController sharedInstance] addSnapshotWithImage:image];
    }];
    
}

- (void)alertView {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Snapshot saved!" message:nil delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)shareButtonPressed:(id)sender {
    
    [self snapshotMapImage:^(UIImage *image) {
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:@[image] applicationActivities:nil];
        [self presentViewController:activityViewController animated:YES completion:nil];

    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    self.pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"personAnnotation"];
    
    self.pinAnnotation.pinColor = MKPinAnnotationColorPurple;

    self.pinAnnotation.animatesDrop = YES;
    
    return self.pinAnnotation;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

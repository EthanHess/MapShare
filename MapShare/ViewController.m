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

#define IS_IPHONE_4 ([UIScreen mainScreen].bounds.size.height == 480.0)


@interface ViewController () <UISearchBarDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) id <MKAnnotation> selectedAnnotation;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SoundController *soundController;
@property (nonatomic, strong) DismissView *dismissView;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, assign) MKMapType currentMapType;
@property (nonatomic, strong) MKPinAnnotationView *pinAnnotation;
//@property (nonatomic, assign) MKPinAnnotationColor pinColor;
@property (nonatomic, strong) UIColor *pinTintColor;
@property (nonatomic, strong) NSArray *arrayOfPins;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *collectionContainerView;


@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [[self navigationController] setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calloutView = [[CalloutView alloc] init];
    
    self.arrayOfPins =[NSArray new];
    
//    self.pinColor = MKPinAnnotationColorRed;
    
    self.pinTintColor = [UIColor redColor];
    
    self.soundController = [SoundController new];
    
    [self setUpMapView];
    
    [self setUpToolBar];
    
    [self setUpNavigationToolBar];
    
    [self setUpSearchBar];
    
    [self settingAnnotations];
    
    [self setUpDismissView];
    
    [self setUpTableView];
    
    [self setUpCollectionView];
    
    [self.view bringSubviewToFront:self.navToolBar];
    
    [self.calloutView setHidden:YES];
    
    [self.view addSubview:self.calloutView];
    
    
}



- (void)setUpMapView {
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 75)];
    self.mapView.delegate = self;
    [self.mapView setMapType:MKMapTypeHybrid];
    self.currentMapType = MKMapTypeHybrid;
    [self.view addSubview:self.mapView];
    
    UITapGestureRecognizer *pressRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapPressGesture:)];
    [self.mapView addGestureRecognizer:pressRecognizer];
    
    
}

- (void)setUpNavigationToolBar {
    
    self.navToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    [self.navToolBar setBackgroundImage:[UIImage imageNamed:@"toolbarBackground"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.navToolBar];
    
    UIImage *pencil = [UIImage imageNamed:@"pencil"];
    UIImage *question = [UIImage imageNamed:@"question"];
    UIImage *search = [UIImage imageNamed:@"search"];
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
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithImage:search style:UIBarButtonItemStylePlain target:self action:@selector(popSearchBar)];
    [navItems addObject:searchButton];
    
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
    [self.toolBar setBackgroundImage:[UIImage imageNamed:@"toolbarBackground"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.toolBar];
    
    UIImage *map = [UIImage imageNamed:@"map"];
    UIImage *boom = [UIImage imageNamed:@"boom"];
    UIImage *zoom = [UIImage imageNamed:@"zoomOut"];
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
    
    UIBarButtonItem *zoomOut = [[UIBarButtonItem alloc]initWithImage:zoom style:UIBarButtonItemStylePlain target:self action:@selector(zoomOut)];
    [buttons addObject:zoomOut];
    
    UIBarButtonItem *flexItem3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem3];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithImage:photo style:UIBarButtonItemStylePlain target:self action:@selector(saveSnapshot)];
    [buttons addObject:shareButton];
    
    UIBarButtonItem *flexItem4 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexItem4];
    
    [self.toolBar setItems:buttons];
}

- (void)changePinColor {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pin Color" message:@"Pick a color!" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Red" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
//        self.pinColor = MKPinAnnotationColorRed;
        self.pinTintColor = [UIColor redColor];
        for (MKPinAnnotationView * pin in self.arrayOfPins) {
            [self.mapView removeAnnotation:pin.annotation];
            pin.pinColor = MKPinAnnotationColorRed;
            [self.mapView addAnnotation:pin.annotation];
            
        }
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Green" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
//        self.pinColor = MKPinAnnotationColorGreen;
        self.pinTintColor = [UIColor greenColor];
        for (MKPinAnnotationView * pin in self.arrayOfPins) {
            [self.mapView removeAnnotation:pin.annotation];
            pin.pinColor = MKPinAnnotationColorGreen;
            [self.mapView addAnnotation:pin.annotation];
            
        }
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Blue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
//        self.pinColor = MKPinAnnotationColorPurple;
        self.pinTintColor = [UIColor blueColor];
        for (MKPinAnnotationView * pin in self.arrayOfPins) {
            [self.mapView removeAnnotation:pin.annotation];
            pin.pinColor = MKPinAnnotationColorPurple;
            [self.mapView addAnnotation:pin.annotation];
            
        }
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Custom" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //pop out collection view with custom color here!
        
        if (self.collectionContainerView.frame.origin.x < 0) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.collectionContainerView.center = CGPointMake(self.collectionContainerView.center.x + self.view.frame.size.width / 2, self.collectionContainerView.center.y);
            
        }];
            
        }
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)archivesController {
    
    SnapshotCollectionView *snapshotView = [SnapshotCollectionView new];
    
    [self.navigationController pushViewController:snapshotView animated:YES];
    
}

- (void)onboarding {
    
    //eventually make page view controller
    
    OnBoardMainView *onboardMainView = [OnBoardMainView new];
    
    [self.navigationController pushViewController:onboardMainView animated:YES];
    
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [self.searchBarView.searchBar becomeFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [self.searchBarView.searchBar resignFirstResponder];
}

- (void)mapType {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Map Type" message:@"Choose Style" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Hybrid" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.mapView setMapType:MKMapTypeHybrid];
        self.currentMapType = MKMapTypeHybrid;
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Satellite" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.mapView setMapType:MKMapTypeSatellite];
        self.currentMapType = MKMapTypeSatellite;
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Standard" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.mapView setMapType:MKMapTypeStandard];
        self.currentMapType = MKMapTypeStandard;
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)setUpSearchBar {
    
    self.searchBarView = [[SearchBarView alloc] initWithFrame:CGRectMake(0, -80, self.view.frame.size.width, 80)];
    [self.view addSubview:self.searchBarView];
    
    [self.searchBarView.button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)popSearchBar {
    
    if (self.searchBarView.frame.origin.y < 75) {
        
        [self popSearchBar:self.searchBarView distance:self.searchBarView.frame.size.height + 75];
        [self.searchBarView.searchBar becomeFirstResponder];
        
    }
    else {
        
        [self popSearchBarBack:self.searchBarView distance:self.searchBarView.frame.size.height + 75];
        [self.searchBarView.searchBar resignFirstResponder];
        
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
    
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:dropPin reuseIdentifier:[NSString stringWithFormat:@"pin %lu",(unsigned long)self.arrayOfPins.count]];
    self.arrayOfPins = [self.arrayOfPins arrayByAddingObject:pin];
    
    [self.mapView addAnnotation:dropPin];
    [self playClongSound];
    
}

- (void)playClongSound {
    
    NSURL *urlForClong = [[NSBundle mainBundle] URLForResource:@"clong-1" withExtension:@"mp3"];
    
    [self.soundController playAudioFileAtURL:urlForClong];
    
}

#pragma mark - adding annotations

- (void)settingAnnotations {
    
    NSArray *locations = [LocationController sharedInstance].locations;
    
    for (Location *location in locations) {
        double latitudeDouble = [location.latitude doubleValue];
        double longitudeDouble = [location.longitude doubleValue];
        
        CLLocationCoordinate2D locCoord = CLLocationCoordinate2DMake(latitudeDouble, longitudeDouble);
        
        MapAnnotation *dropPin = [[MapAnnotation alloc] initWithLocation:locCoord];
        MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:dropPin reuseIdentifier:[NSString stringWithFormat:@"pin %lu",(unsigned long)self.arrayOfPins.count]];
        self.arrayOfPins = [self.arrayOfPins arrayByAddingObject:pin];
        
        [self.mapView addAnnotation:dropPin];
        
    }
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    self.calloutView.annotation = view.annotation;
    
    [self.calloutView setFrame:CGRectMake(view.center.x, view.center.y, 80, 100)];
    
    [self.calloutView.removeButton addTarget:self action:@selector(removeLocation) forControlEvents:UIControlEventTouchUpInside];
    self.selectedAnnotation = view.annotation;
    [self.calloutView setHidden:NO];
    
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
                [self.searchBarView.searchBar resignFirstResponder];
                self.resultPlaces = [response mapItems];
                [self setUpTableView];
                [self.dismissView setHidden:NO];
                [self.tableView reloadData];
            } else {
                [self errorMessage];
            }
        }];
        
        
    }
    
}

- (void)errorMessage {
    
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"No Results" message:@"Search Again" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [errorAlert show];
}

#pragma CollectionView for pin colors

- (void)popBack {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (self.collectionContainerView.frame.origin.x >= 0) {
            
            self.collectionContainerView.center = CGPointMake(self.collectionContainerView.center.x - self.view.frame.size.width / 2, self.collectionContainerView.center.y);
        }
        
    }];
}

- (void)setUpCollectionView {
    
    self.collectionContainerView = [[UIView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width / 2, 150, self.view.frame.size.width / 2, self.view.frame.size.height / 2)];
    self.collectionContainerView.layer.cornerRadius = 15;
    self.collectionContainerView.backgroundColor = [UIColor whiteColor];
    self.collectionContainerView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.collectionContainerView.layer.borderWidth = 2;
    self.collectionContainerView.layer.masksToBounds = YES;
    [self.view addSubview:self.collectionContainerView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.collectionContainerView.frame.size.width / 2 - 25, self.collectionContainerView.frame.size.height - 75, 50, 50)];
    [backButton setTitle:@"<" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.layer.cornerRadius = 25;
    backButton.layer.borderColor = [[UIColor blackColor]CGColor];
    backButton.layer.borderWidth = 2;
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionContainerView addSubview:backButton];
    
    //establish layout
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.collectionContainerView.frame.size.width, self.view.frame.size.height / 3) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self registerCollectionView:self.collectionView];
    [self.collectionContainerView addSubview:self.collectionView];
}

- (void)registerCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //remember to add for view in subviews for loop
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = cell.frame.size.height / 2;
    cell.layer.borderColor = [[UIColor blackColor]CGColor];
    cell.layer.borderWidth = 1;
    cell.backgroundColor = [self customColors][indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self customColors].count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.pinTintColor = [self customColors][indexPath.row];
    
}

- (NSArray *)customColors {
    
    //change to better colors eventually
    
    UIColor *yellowColor = [UIColor yellowColor];
    UIColor *orangeColor = [UIColor orangeColor];
    UIColor *cyanColor = [UIColor cyanColor];
    UIColor *blackColor = [UIColor blackColor];
    UIColor *grayColor = [UIColor grayColor];
    UIColor *whiteColor = [UIColor whiteColor];
    UIColor *purpleColor = [UIColor purpleColor];
    UIColor *brownColor = [UIColor brownColor];
    UIColor *randomColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    NSArray *colorArray = @[yellowColor, orangeColor, cyanColor, blackColor, grayColor, whiteColor, purpleColor, brownColor, randomColor];
    
    return colorArray;
}

#pragma TableView for MKMapItems (locations)


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
    
    if (IS_IPHONE_4) {
        
        if (self.resultPlaces.count < 3) {
            tableViewHeight = 80 * self.resultPlaces.count;
        }
        else {
            tableViewHeight = 80 * 2;
        }
    }
    
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(80, 240, self.view.frame.size.width - 160, tableViewHeight)];
    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    self.tableView.layer.borderWidth = 2;
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
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.text = item.placemark.title;
    cell.detailTextLabel.font = [UIFont fontWithName:@"Chalkduster" size:14];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.numberOfLines = 0;
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

#pragma mark - clears all

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    if (buttonIndex == 1) {
        
        for (Location *location in [LocationController sharedInstance].locations) {
            
            [[LocationController sharedInstance] removeLocation:location];
            
        }
        
        self.arrayOfPins = @[];
        
        
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
    options.mapType = self.currentMapType;
    options.showsPointsOfInterest = YES;
    
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        
        UIImage *image = snapshot.image;
        
        // Get the size of the final image
        
        CGRect finalImageRect = CGRectMake(0, 0, image.size.width, image.size.height);
        
        MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:@""];
//        pin.pinColor = self.pinColor;
        pin.pinTintColor = self.pinTintColor;
        UIImage *pinImage = pin.image;
        
        //create final image
        
        UIGraphicsBeginImageContextWithOptions(image.size, YES, image.scale);
        
        [image drawAtPoint:CGPointMake(0, 0)];
        
        //iterate through annotations
        
        for (id<MKAnnotation>annotation in self.mapView.annotations)
        {
            CGPoint point = [snapshot pointForCoordinate:annotation.coordinate];
            if (CGRectContainsPoint(finalImageRect, point)) // this is too conservative, but you get the idea
            {
                CGPoint pinCenterOffset = pin.centerOffset;
                point.x -= pin.bounds.size.width / 2.0;
                point.y -= pin.bounds.size.height / 2.0;
                point.x += pinCenterOffset.x;
                point.y += pinCenterOffset.y;
                
                [pinImage drawAtPoint:point];
            }
        }
        
        // grab the final image
        
        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        completion(finalImage);
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
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Snapshot saved!" message:@"Now add a caption" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Add caption";
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save caption" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self snapshotMapImage:^(UIImage *image) {
            [[SnapshotController sharedInstance] addSnapshotWithImage:image caption:((UITextField*)alertController.textFields[0]).text];
        }];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    [self playSnapSound];
    
    
}

- (void)playSnapSound {
    
    NSURL *urlForSnap = [[NSBundle mainBundle] URLForResource:@"snapSound" withExtension:@"mp3"];
    
    [self.soundController playAudioFileAtURL:urlForSnap];
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    
    self.pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pinAnnotation"];
    
//    self.pinAnnotation.pinColor = self.pinColor;
    
    self.pinAnnotation.pinTintColor = self.pinTintColor;
    
    //TODO set better custom colors
    
    self.pinAnnotation.animatesDrop = YES;
    
    return self.pinAnnotation;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

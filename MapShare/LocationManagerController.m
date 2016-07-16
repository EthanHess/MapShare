//
//  LocationManagerController.m
//  MapShare
//
//  Created by Ethan Hess on 7/15/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "LocationManagerController.h"

@implementation LocationManagerController

+ (LocationManagerController *)sharedInstance {
    static LocationManagerController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [LocationManagerController new];
    });
    
    return sharedInstance;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.locationReady = NO;
        
        self.manager = [[CLLocationManager alloc]init];
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.delegate = self;
        [self.manager requestWhenInUseAuthorization];
        [self.manager startUpdatingLocation];
    
        
    }
    return self;
}

- (void)getCurrentLocationWithCompletion:(void (^)(CLLocationCoordinate2D currentLocation, BOOL success))completion {
    
    if (self.currentLocation) {
        
        completion(*(_currentLocation), YES);
    }
        
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    if (locations.lastObject) {
    
    CLLocation *mostRecentLocation = locations.lastObject;
        
        CLLocationCoordinate2D currentLocation = CLLocationCoordinate2DMake(mostRecentLocation.coordinate.latitude, mostRecentLocation.coordinate.longitude);
        
        self.currentLocation = &(currentLocation);
        
        self.locationReady = YES;
        
        [self.manager stopUpdatingLocation];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LocationReady" object:nil];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"ERROR: %@", error.localizedDescription);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error: Please check your internet connection" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.manager startUpdatingLocation];
        
        [[[[UIApplication sharedApplication]keyWindow]rootViewController]dismissViewControllerAnimated:YES completion:nil];
    }]; 
    
    [alertController addAction:action];
    
    [[[[UIApplication sharedApplication]keyWindow] rootViewController]presentViewController:alertController animated:YES completion:nil]; 
}

@end

//
//  ResultsController.m
//  MapShare
//
//  Created by Ethan Hess on 4/13/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "ResultsController.h"
#import "ViewController.h"

@implementation ResultsController


- (void)getLocations {
    
    ViewController *viewController = [ViewController new];

    NSString *searchText = viewController.searchBarView.searchBar.text;

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


@end

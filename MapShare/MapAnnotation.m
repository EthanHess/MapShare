//
//  MapAnnotation.m
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        
        coordinate = coord;
        
    }
    return self;
}

//- (id)initWithLocation:(Location *)location {
//    
//    self = [super init];
//    if (self) {
//        
//        float lat = [location.latitude floatValue];
//        float lon = [location.longitude floatValue];
//        
//        coordinate = CLLocationCoordinate2DMake(lat,lon);
//        
//    }
//    
//    return self;
//}


@end

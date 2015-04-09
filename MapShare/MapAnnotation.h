//
//  MapAnnotation.h
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
#import "Location.h"

@interface MapAnnotation : MKAnnotationView <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) Location *currentLocation;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end

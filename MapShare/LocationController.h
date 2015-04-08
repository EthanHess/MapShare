//
//  LocationController.h
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationController : NSObject

@property (nonatomic, strong, readonly) NSArray *locations;

+ (LocationController *)sharedInstance;

- (void)addLocationWithLatitude:(NSString *)latitude longitude:(NSString *)longitude;

@end

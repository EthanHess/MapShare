//
//  ResultsController.h
//  MapShare
//
//  Created by Ethan Hess on 4/13/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultsController : NSObject

@property (nonatomic, strong, readonly) NSArray *places;

+ (ResultsController *)sharedInstance;

@end

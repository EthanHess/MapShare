//
//  SnapshotController.h
//  MapShare
//
//  Created by Ethan Hess on 4/17/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Snapshot.h"

@interface SnapshotController : NSObject

@property (nonatomic, strong) NSArray *snapshots;

+ (SnapshotController *)sharedInstance;

- (void)addSnapshotWithImage:(UIImage *)image caption:(NSString *)caption;

- (void)addPicture:(UIImage *)image; 

- (void)removeSnapshots:(Snapshot *)snapshot;

@end

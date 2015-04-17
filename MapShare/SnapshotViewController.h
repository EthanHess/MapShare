//
//  SnapshotViewController.h
//  MapShare
//
//  Created by Ethan Hess on 4/17/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Snapshot.h"

@interface SnapshotViewController : UIViewController

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) Snapshot *snapshot;
@property (nonatomic, strong) UIButton *shareButton;

@end

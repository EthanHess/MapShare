//
//  SnapshotViewController.m
//  MapShare
//
//  Created by Ethan Hess on 4/17/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "SnapshotViewController.h"
#import "UIColor+UIColorCategory.h"
#import "SnapshotCollectionView.h"

@interface SnapshotViewController ()

@end

@implementation SnapshotViewController

- (void)updateWithSnapshot:(Snapshot *)snapshot {
    
    self.snapshot = snapshot;
    
    UIImage *image = [UIImage imageWithData:snapshot.snapshot];
    
    self.imageView.image = image;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpToolBar];
    
    [self setUpImageView];

}

- (void)setUpToolBar {
    
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"cloud"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.toolbar];
    
    UIImage *arrow = [UIImage imageNamed:@"leftArrow"];
    
    NSMutableArray *navItems = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *flexItem0 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem0];
    
    UIBarButtonItem *arrowButton = [[UIBarButtonItem alloc]initWithImage:arrow style:UIBarButtonItemStylePlain target:self action:@selector(collectionView)];
    [navItems addObject:arrowButton];
    
    UIBarButtonItem *flexItem2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem2];
    
    [self.toolbar setItems:navItems];
    
}

- (void)collectionView {
    
    SnapshotCollectionView *collectionView = [SnapshotCollectionView new];
    
    [self.navigationController pushViewController:collectionView animated:YES];
    
}

- (void)setUpImageView {
    
    self.view.backgroundColor = [UIColor backgroundColor];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, self.view.frame.size.width - 100, self.view.frame.size.height - 150)];
    self.imageView.backgroundColor = [UIColor awesome];
    [self.view addSubview:self.imageView];
    
    [self updateWithSnapshot:self.snapshot];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

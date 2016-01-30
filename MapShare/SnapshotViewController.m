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
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"SnapBack"];
    [self.view addSubview:imageView];
    
    [self setUpScrollView];
    
    [self setUpToolBar];
    
    [self setUpImageView];
    
    [self setUpButton];
    

}

- (void)setUpScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 250);
    
    [self.view sendSubviewToBack:self.scrollView];
    
    [self.view addSubview:self.scrollView];
    
}

- (void)setUpButton {
    
    self.shareButton = [[ShareButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 60, 500, 120, 120)];
    [self.shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.shareButton];
    
}

- (void)setUpToolBar {
    
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"darkGreenPaper"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
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
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 100, self.view.frame.size.width - 30, self.view.frame.size.width - 30)];
    self.imageView.layer.masksToBounds = YES; 
    self.imageView.layer.cornerRadius = 10;
    self.imageView.layer.borderColor = [[UIColor goldColor]CGColor];
    self.imageView.layer.borderWidth = 2;
    self.imageView.backgroundColor = [UIColor awesome];
    [self.scrollView addSubview:self.imageView];
    
    [self updateWithSnapshot:self.snapshot];
    
}

- (void)share {
    
    UIImage *image = self.imageView.image;
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:@[image] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

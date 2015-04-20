//
//  SnapshotCollectionView.m
//  MapShare
//
//  Created by Ethan Hess on 4/17/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "SnapshotCollectionView.h"
#import "ViewController.h"
#import "UIColor+UIColorCategory.h"
#import "SnapshotViewController.h"
#import "SnapshotCollectionViewCell.h"
#import "SnapshotController.h"
#import "Snapshot.h"

@interface SnapshotCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>


@end

@implementation SnapshotCollectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [SnapshotCollectionViewCell new];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavbar];
    
    [self setUpCollectionView];
    
}

- (void)setUpNavbar {
    
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"abstractBlue"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.toolbar];
    
    UIImage *arrow = [UIImage imageNamed:@"leftArrow"];
    
    NSMutableArray *navItems = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *flexItem0 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem0];
    
    UIBarButtonItem *arrowButton = [[UIBarButtonItem alloc]initWithImage:arrow style:UIBarButtonItemStylePlain target:self action:@selector(home)];
    [navItems addObject:arrowButton];
    
    UIBarButtonItem *flexItem2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem2];
    
    [self.toolbar setItems:navItems];
    
}

- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor backgroundColor];
    
    layout.sectionInset = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self registerCollectionView:self.collectionView];
    [self.view addSubview:self.collectionView];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.view.frame.size.width / 2) - 8,180);
}

- (void)home {
    
    ViewController *viewController = [ViewController new];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)registerCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:[SnapshotCollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Options" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"View Large" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        SnapshotViewController *snapshotViewController = [SnapshotViewController new];
        snapshotViewController.snapshot = [SnapshotController sharedInstance].snapshots[indexPath.item];
        [self.navigationController pushViewController:snapshotViewController animated:YES];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        Snapshot *snapshot = [[SnapshotController sharedInstance].snapshots objectAtIndex:indexPath.item];
        
        [[SnapshotController sharedInstance]removeSnapshots:snapshot];
        
        [self refreshData]; 
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:alertController completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [SnapshotController sharedInstance].snapshots.count;
    
}

- (SnapshotCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SnapshotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    
    NSArray *subviews = [cell.contentView subviews];
    
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    
    Snapshot *snapshot =[SnapshotController sharedInstance].snapshots[indexPath.row];
    UIImage *image = [UIImage imageWithData:snapshot.snapshot];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    imageView.frame = cell.bounds;
    [cell addSubview:imageView];
    
    cell.footerLabel.text = snapshot.caption;
    cell.footerLabel.font = [UIFont fontWithName:@"Chalkduster" size:20];
    cell.footerLabel.textColor = [UIColor brownColor];
    cell.footerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"parchment"]];
    [cell bringSubviewToFront:cell.footerLabel];

    return cell;
    
}

- (void)refreshData {
    
    [self.collectionView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

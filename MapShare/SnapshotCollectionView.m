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

@property (nonatomic, strong) UIView *toolbarContainer;

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
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    //@"spaceCollectionBG" << old
    imageView.image = [UIImage imageNamed:@"SnapshotGalleryBG"];
    [self.view addSubview:imageView];
    
    [self setUpTopContainer];
    [self setUpCollectionView];
}

- (void)setUpTopContainer {
    if (self.toolbarContainer == nil) {
        self.toolbarContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
        self.toolbarContainer.backgroundColor = [UIColor blackColor];
        self.toolbarContainer.userInteractionEnabled = YES;
        [self.view addSubview:self.toolbarContainer];
        [self setUpNavbar];
    }
}

- (void)setUpNavbar {
    
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, 75)];
    [self.toolbar setBarTintColor:[UIColor blackColor]];
    [self.toolbarContainer addSubview:self.toolbar];
    
    UIImage *arrow = [UIImage imageNamed:@"leftArrow"];
    
    NSMutableArray *navItems = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *flexItem0 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem0];
    
    UIBarButtonItem *arrowButton = [[UIBarButtonItem alloc]initWithImage:arrow style:UIBarButtonItemStylePlain target:self action:@selector(home)];
    arrowButton.tintColor = [UIColor whiteColor];
    [navItems addObject:arrowButton];
    
    UIBarButtonItem *flexItem2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [navItems addObject:flexItem2];
    
    [self.toolbar setItems:navItems];
    
}

- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [UIColor clearColor];     //TODO: Change to custom
    
    layout.sectionInset = UIEdgeInsetsMake(80, 50, 80, 50);
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self registerCollectionView:self.collectionView];
    [self.view addSubview:self.collectionView];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width - 100) ,self.view.frame.size.width - 100);
}

- (void)home {
    [self.navigationController popViewControllerAnimated:YES];
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
        [self dismissViewControllerAnimated:YES completion:nil];
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
    cell.footerLabel.font = [UIFont systemFontOfSize:12]; 
    cell.footerLabel.textColor = [UIColor whiteColor];
    cell.footerLabel.backgroundColor = [UIColor blackColor];
    cell.layer.cornerRadius = 10;
    cell.layer.borderColor = [[UIColor whiteColor]CGColor];
    cell.layer.borderWidth = 3;
    cell.layer.masksToBounds = YES; 
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

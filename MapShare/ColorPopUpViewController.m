//
//  ColorPopUpViewController.m
//  MapShare
//
//  Created by Ethan Hess on 12/15/18.
//  Copyright © 2018 Ethan Hess. All rights reserved.
//

#import "ColorPopUpViewController.h"
#import "UIColor+UIColorCategory.h" //Custom colors
#import "ColorCell.h"

@interface ColorPopUpViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ColorPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //self.view.backgroundColor = //Transparent
    [self registerCollectionView];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    CGRect collectionFrame = CGRectMake(50, 100, self.view.frame.size.width - 100, self.view.frame.size.height - 200);
    self.collectionView = [[UICollectionView alloc]initWithFrame:collectionFrame collectionViewLayout:layout];
    [self.collectionView registerClass:[ColorCell class] forCellWithReuseIdentifier:@"cCell"];
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.layer.cornerRadius = 5;
    self.collectionView.layer.borderWidth = 1;
    self.collectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blueStars"]];
    //self.collectionView.backgroundView.alpha = 0.5;
    [self.view addSubview:self.collectionView];
}

#pragma Collection VC DS + DEL

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self customColors].count;
}

- (NSArray *)customColors {
    UIColor *yellowColor = [UIColor customYellow];
    UIColor *orangeColor = [UIColor customOrange];
    UIColor *cyanColor = [UIColor customCyan];
    UIColor *blackColor = [UIColor customBlack];
    UIColor *grayColor = [UIColor customGray];
    UIColor *whiteColor = [UIColor customWhite];
    UIColor *purpleColor = [UIColor customPurple];
    UIColor *brownColor = [UIColor customBrown];
    
    UIColor *randomColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    NSArray *colorArray = @[yellowColor, orangeColor, cyanColor, blackColor, grayColor, whiteColor, purpleColor, brownColor, randomColor];
    
    return colorArray;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ColorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cCell" forIndexPath:indexPath];
    [cell animateWithDuration:indexPath.row / 2 andColor:[self customColors][indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIColor *color = [self customColors][indexPath.row];
    [self.delegate didChooseColor:color]; 
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat dimension = (self.view.frame.size.width / 2) - 100;
    return CGSizeMake(dimension, dimension);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

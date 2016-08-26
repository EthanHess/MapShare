//
//  PictureChoiceCollectionViewController.m
//  MapShare
//
//  Created by Ethan Hess on 8/26/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "PictureChoiceCollectionViewController.h"
#import "SnapshotController.h"

@interface PictureChoiceCollectionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionView *pictureCollectionView;
@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) UIButton *chooseImageButton;
@property (nonatomic, strong) UIImage *chosenImage;

@end

@implementation PictureChoiceCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
    
    [self setUpCollectionView];
}

- (void)setUpViews {
    
    CGFloat halfScreen = self.view.frame.size.width / 2;
    CGRect buttonFrameOne = CGRectMake(0, 0, halfScreen, 65);
    
    self.chooseImageButton = [[UIButton alloc]initWithFrame:buttonFrameOne];
    [self.chooseImageButton setTitle:@"Choose Image" forState:UIControlStateNormal];
    self.chooseImageButton.backgroundColor = [UIColor blackColor];
    self.chooseImageButton.titleLabel.textColor = [UIColor whiteColor];
    [self.chooseImageButton addTarget:self action:@selector(popImagePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chooseImageButton];
    
    CGRect buttonFrameTwo = CGRectMake(halfScreen, 0, halfScreen, 65);
    
    self.dismissButton = [[UIButton alloc]initWithFrame:buttonFrameTwo];
    [self.dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    self.dismissButton.backgroundColor = [UIColor blackColor];
    self.dismissButton.titleLabel.textColor = [UIColor whiteColor];
    [self.dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dismissButton];
}

- (void)setUpCollectionView {
    
    CGRect collectionViewFrame = CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height - 65);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    _pictureCollectionView = [[UICollectionView alloc]initWithFrame:collectionViewFrame collectionViewLayout:layout];
    _pictureCollectionView.delegate = self;
    _pictureCollectionView.dataSource = self;
    [self registerCollectionView:_pictureCollectionView];
    [self.view addSubview:_pictureCollectionView];
    
}

- (void)dismiss {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //maybe pop alert asking if they want to use image view nsnotification?
}

- (void)popImagePicker {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)registerCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    return cell;
    
}

- (void)configureCell:(UICollectionViewCell *)cell withImage:(UIImage *)image {
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}

//image picker methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    self.chosenImage = info[UIImagePickerControllerEditedImage];
    
    [[SnapshotController sharedInstance]addPicture:self.chosenImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

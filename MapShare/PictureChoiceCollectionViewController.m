//
//  PictureChoiceCollectionViewController.m
//  MapShare
//
//  Created by Ethan Hess on 8/26/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "PictureChoiceCollectionViewController.h"
#import "PictureController.h"
#import "Picture.h"
#import "ViewController.h"

@interface PictureChoiceCollectionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionView *pictureCollectionView;
@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) UIButton *chooseImageButton;
@property (nonatomic, strong) UIImage *chosenImage;

@end

@implementation PictureChoiceCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setUpViews];
    [self setUpCollectionView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.pictureCollectionView reloadData]; 
}

- (void)setUpViews {
    
    CGFloat halfScreen = self.view.frame.size.width / 2;
    CGRect buttonFrameOne = CGRectMake(0, 0, halfScreen, 65);
    
    self.chooseImageButton = [[UIButton alloc]initWithFrame:buttonFrameOne];
    [self.chooseImageButton setTitle:@"Upload Image" forState:UIControlStateNormal];
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
    
    CGRect backgroundImageFrame = CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height - 65);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:backgroundImageFrame];
    imageView.image = [UIImage imageNamed:@"spaceCollectionBG"];
    [self.view addSubview:imageView]; 
}

- (void)setUpCollectionView {
    
    CGRect collectionViewFrame = CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height - 65);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    
    _pictureCollectionView = [[UICollectionView alloc]initWithFrame:collectionViewFrame collectionViewLayout:layout];
    _pictureCollectionView.delegate = self;
    _pictureCollectionView.dataSource = self;
    _pictureCollectionView.backgroundColor = [UIColor clearColor];
    [self registerCollectionView:_pictureCollectionView];
    [self.view addSubview:_pictureCollectionView];
    
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
    //maybe pop alert asking if they want to use image via nsnotification?
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
    
    //prevents image overlap
    
    NSArray *subviews = [cell.contentView subviews];
    
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    
    Picture *picture = [PictureController sharedInstance].pictures[indexPath.row];
    [self configureCell:cell withImageData:picture.picData];
    
    return cell;
    
}

//choppy scrolling, fix!

- (void)configureCell:(UICollectionViewCell *)cell withImageData:(NSData *)imageData {
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:cell.bounds];
    backgroundImageView.image = [UIImage imageWithData:imageData];
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    [cell.contentView addSubview:backgroundImageView];
}

//- (void)configureCell:(UICollectionViewCell *)cell withImageData:(NSData *)imageData {
//    
//    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:cell.bounds];
//    
//    UIImage __block *imageFromData = nil;
//    
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        imageFromData = [UIImage imageWithData:imageData];
//    });
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        cell.layer.cornerRadius = 10;
//        cell.layer.masksToBounds = YES;
//
//        backgroundImageView.image = imageFromData;
//        [cell.contentView addSubview:backgroundImageView];
//    });
//}

//maybe this is the solution?

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:    (UICollectionViewLayoutAttributes *)layoutAttributes {
    return layoutAttributes;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [PictureController sharedInstance].pictures.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width / 2) - 8, 180);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Picture *picture = [PictureController sharedInstance].pictures[indexPath.row];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Use or delete?" message:@"Use as annotation picture or discard?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self storeImageData:picture.picData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self postNotificationWithName:@"pictureAdded"];
        });
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[PictureController sharedInstance]removePicture:picture];
        [self refresh];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:addAction];
    [alertController addAction:deleteAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//image picker methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //self.chosenImage = info[UIImagePickerControllerEditedImage];
    self.chosenImage = info[UIImagePickerControllerOriginalImage];
    
    [[PictureController sharedInstance]addPicture:self.chosenImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self refresh];
}

- (void)storeImageData:(NSData *)data {
    
    NSString *imagePath = [self documentsPathForFileName:[NSString stringWithFormat:@"image_%f.jpg", [NSDate timeIntervalSinceReferenceDate]]];

    [data writeToFile:imagePath atomically:YES];
    [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:@"annotationImageData"]; //make constant?
}

- (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

- (void)postNotificationWithName:(NSString *)notificationName {
    [[NSNotificationCenter defaultCenter]postNotificationName:notificationName object:nil];
}

- (void)refresh {
    [self.pictureCollectionView reloadData];
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

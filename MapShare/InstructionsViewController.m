//
//  InstructionsViewController.m
//  MapShare
//
//  Created by Ethan Hess on 7/15/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "InstructionsViewController.h"
#import "UIColor+UIColorCategory.h"

@interface InstructionsViewController ()

@property (nonatomic, strong) UILabel *instructionsLabel;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *dismissLabel;
@property (nonatomic, strong) UILabel *creditsLabel;
@property (nonatomic, strong) UILabel *urlLabel;

@end

@implementation InstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIColor *background = [UIColor colorWithRed:15.0f/255.0f green:146.0f/255.0f blue:172.0f/255.0f alpha:1.0];
    
    UIColor *background = [UIColor darkGrayColor];
    
    //self.view.backgroundColor = [UIColor instructionsBackground];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGRect containerFrame = CGRectMake(20, 60, self.view.frame.size.width - 40, 320);
    
    self.containerView = [[UIView alloc]initWithFrame:containerFrame];
    self.containerView.backgroundColor = background;
    self.containerView.layer.cornerRadius = 10;
    [self.view addSubview:self.containerView];
    
    CGRect labelFrame = CGRectMake(10, 10, self.containerView.frame.size.width - 20, 300);
    
    self.instructionsLabel = [[UILabel alloc]initWithFrame:labelFrame];
    self.instructionsLabel.layer.masksToBounds = YES;
    self.instructionsLabel.layer.cornerRadius = 10;
    self.instructionsLabel.numberOfLines = 0;
    self.instructionsLabel.backgroundColor = background;
    self.instructionsLabel.textColor = [UIColor whiteColor];
    self.instructionsLabel.textAlignment = NSTextAlignmentCenter;
    self.instructionsLabel.text = @"Welcome to Snapption! Tap the map to drop pins on notable places where you've traveled. Use the search icon on the toolbar to zoom in on certain cities and landmarks. When you've established an impressive collection, click the camera icon to snapshot it and give it a name. Head over to the archives with the top right button and view your saved snapshots, select one to view large and share!";
    [self.containerView addSubview:self.instructionsLabel];
    
    CGRect dismissFrame = CGRectMake(20, 400, self.view.frame.size.width - 40, 25);

    self.dismissLabel = [[UILabel alloc]initWithFrame:dismissFrame];
    self.dismissLabel.text = @"Tap to dismiss";
    self.dismissLabel.backgroundColor = [UIColor clearColor];
    self.dismissLabel.textColor = [UIColor whiteColor];
    self.dismissLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.dismissLabel];
    
    CGRect creditsFrame = CGRectMake(0, 425, self.view.frame.size.width, 25);
    
    self.creditsLabel = [[UILabel alloc]initWithFrame:creditsFrame];
    self.creditsLabel.text = @"Toolbar images courtesy of icons8.com";
    self.creditsLabel.backgroundColor = [UIColor clearColor];
    self.creditsLabel.textColor = [UIColor whiteColor];
    self.creditsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.creditsLabel];
    
    CGRect urlFrame = CGRectMake(0, 450, self.view.frame.size.width, 25);
    
    self.urlLabel = [[UILabel alloc]initWithFrame:urlFrame];
    self.urlLabel.text = @"http://www.icons8.com"; 
    self.urlLabel.backgroundColor = [UIColor clearColor];
    self.urlLabel.textColor = [UIColor yellowColor];
    self.urlLabel.textAlignment = NSTextAlignmentCenter;
    self.urlLabel.userInteractionEnabled = YES;
    [self.view addSubview:self.urlLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openURL)];
    
    [self.urlLabel addGestureRecognizer:tapGesture];
    
}

- (void)openURL {
    
    NSURL *urlToOpen = [NSURL URLWithString:self.urlLabel.text];
    
    UIApplication *app = [UIApplication sharedApplication];
    
    if ([app canOpenURL:urlToOpen]) {
        
        [app openURL:urlToOpen];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
}

- (void)dismiss {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

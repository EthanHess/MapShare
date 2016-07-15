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


@end

@implementation InstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor instructionsBackground];
    
    CGRect labelFrame = CGRectMake(30, 70, self.view.frame.size.width - 60, 300);
    
    self.instructionsLabel = [[UILabel alloc]initWithFrame:labelFrame];
    self.instructionsLabel.layer.masksToBounds = YES;
    self.instructionsLabel.layer.cornerRadius = 10;
    self.instructionsLabel.numberOfLines = 0;
    self.instructionsLabel.backgroundColor = [UIColor colorWithRed:15.0f/255.0f green:146.0f/255.0f blue:172.0f/255.0f alpha:1.0];
    self.instructionsLabel.textColor = [UIColor whiteColor];
    self.instructionsLabel.textAlignment = NSTextAlignmentCenter;
    self.instructionsLabel.text = @"Welcome to Snapption! Press the map to drop pins on notable places where you've traveled. Use the search icon on the toolbar to zoom in certain cities and landmarks. When you've established an impressive collection of travels click the camera icon to snapshot it and give it a name. Head over to the archives with the top right button and view your saved snapshots, select one to view large and share!";
    [self.view addSubview:self.instructionsLabel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
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

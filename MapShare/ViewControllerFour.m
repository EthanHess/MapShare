//
//  ViewControllerFour.m
//  MapShare
//
//  Created by Ethan Hess on 2/24/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "ViewControllerFour.h"

@interface ViewControllerFour ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewControllerFour

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.imageView.image = [UIImage imageNamed:@"OnboardingSearch"];
    
    [self.view addSubview:self.imageView];
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

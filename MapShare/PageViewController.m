//
//  PageViewController.m
//  MapShare
//
//  Created by Ethan Hess on 2/11/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vcOne = [ViewControllerOne new];
    self.vcTwo = [ViewControllerTwo new];
    self.vcThree = [ViewControllerThree new];
    self.vcFour = [ViewControllerFour new];
    self.vcFive = [ViewControllerFive new]; 
    
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageViewController.dataSource = self; 
    
    [self.pageViewController setViewControllers:@[[self vcOne]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if (viewController == self.vcOne) {
        return self.vcTwo;
    } else if (viewController == self.vcTwo) {
        return self.vcThree;
    } else if (viewController == self.vcThree) {
        return self.vcFour;
    } else if (viewController == self.vcFour) {
        return self.vcFive;
    }else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (viewController == self.vcOne) {
        return nil;
    } else if (viewController == self.vcTwo) {
        return self.vcOne;
    } else if (viewController == self.vcThree) {
        return self.vcTwo;
    } else if (viewController == self.vcFour) {
        return self.vcThree;
    } else {
        return self.vcFour;
    }

    
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

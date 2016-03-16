//
//  PageViewController.h
//  MapShare
//
//  Created by Ethan Hess on 2/11/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerOne.h"
#import "ViewControllerTwo.h"
#import "ViewControllerThree.h"
#import "ViewControllerFour.h"
#import "ViewControllerFive.h"

@interface PageViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) ViewControllerOne *vcOne;
@property (nonatomic, strong) ViewControllerTwo *vcTwo;
@property (nonatomic, strong) ViewControllerThree *vcThree;
@property (nonatomic, strong) ViewControllerFour *vcFour;
@property (nonatomic, strong) ViewControllerFive *vcFive; 

@end

//
//  OnBoardMainView.m
//  MapShare
//
//  Created by Ethan Hess on 4/15/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "OnBoardMainView.h"
#import "UIColor+UIColorCategory.h"
#import "ViewController.h"
#import <math.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}

@interface OnBoardMainView ()

@end

@implementation OnBoardMainView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor awesome];
    
    self.soundController = [SoundController new];

    [self setUpScrollView];

    [self setUpToolbar];
    
    [self setUpLabels];
    
    [self.scrollView bringSubviewToFront:self.welcomeLabel];
    
    [self animateLabel:self.welcomeLabel duration:2.0];
    
    [self.view sendSubviewToBack:self.scrollView];
    
    [self playWelcomeSound];
    
}

- (void)setUpScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 500);
    
    [self.view sendSubviewToBack:self.scrollView];
    
    [self.view addSubview:self.scrollView];
    
}

- (void)setUpToolbar {
    
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"grass"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
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

- (void)setUpLabels {
    
    self.welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 90, self.view.frame.size.width - 50, 60)];
    self.welcomeLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"water"]];
    self.welcomeLabel.textColor = [UIColor whiteColor];
    self.welcomeLabel.text = @" Welcome To MapShot! ";
    self.welcomeLabel.font = [UIFont fontWithName:@"Chalkduster" size:24];
    [self.scrollView addSubview:self.welcomeLabel];
    
    self.mapTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 165, self.view.frame.size.width - 50, 185)];
    self.mapTypeLabel.backgroundColor = [UIColor backgroundColor];
    self.mapTypeLabel.textColor = [UIColor whiteColor];
    self.mapTypeLabel.text = @" Use the left button of the botton toolbar to select the map type of your choice. To add annotations simply click anywhere on the screen, either zoomed in or from afar. To delete annotations select the top of the pin then hold and drag to the delete button which pops up. ";
    self.mapTypeLabel.numberOfLines = 0;
    self.mapTypeLabel.font = [UIFont fontWithName:@"Chalkduster" size:16];
    [self.scrollView addSubview:self.mapTypeLabel];
    
    self.searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 365, self.view.frame.size.width - 50, 80)];
    self.searchLabel.backgroundColor = [UIColor backgroundColor];
    self.searchLabel.textColor = [UIColor whiteColor];
    self.searchLabel.text = @" Click the magnifying glass to dispay the search bar then select a location and zoom to it. ";
    self.searchLabel.numberOfLines = 0;
    self.searchLabel.font = [UIFont fontWithName:@"Chalkduster" size:16];
    [self.scrollView addSubview:self.searchLabel];
    
    self.clearAllLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 460, self.view.frame.size.width - 50, 95)];
    self.clearAllLabel.backgroundColor = [UIColor backgroundColor];
    self.clearAllLabel.textColor = [UIColor whiteColor];
    self.clearAllLabel.text = @" If need be you have the option to remove all your annotations at once by clicking the mushroom cloud then selecting 'yes'. ";
    self.clearAllLabel.numberOfLines = 0;
    self.clearAllLabel.font = [UIFont fontWithName:@"Chalkduster" size:16];
    [self.scrollView addSubview:self.clearAllLabel];
    
    self.shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 570, self.view.frame.size.width - 50, 80)];
    self.shareLabel.backgroundColor = [UIColor backgroundColor];
    self.shareLabel.textColor = [UIColor whiteColor];
    self.shareLabel.text = @" Click the far right button on the bottom toolbar to share your map with your friends! ";
    self.shareLabel.numberOfLines = 0;
    self.shareLabel.font = [UIFont fontWithName:@"Chalkduster" size:16];
    [self.scrollView addSubview:self.shareLabel];
    
    
}

- (void)playWelcomeSound {
    
    NSURL *urlForHarp = [[NSBundle mainBundle] URLForResource:@"dreamHarp" withExtension:@"mp3"];
    
    [self.soundController playAudioFileAtURL:urlForHarp];
    
}

- (void)home {
    
    ViewController *viewController = [ViewController new];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)animateLabel:(UIView *)view duration:(float)duration {
    
    CGAffineTransform bigger = CGAffineTransformMakeScale(10, 2);
    CGAffineTransform smaller = CGAffineTransformMakeScale(1, 1);
    CGAffineTransform rotate = CGAffineTransformMakeRotation(radians(180));
//    CGAffineTransform move = CGAffineTransformMakeTranslation(0, +300);
//    CGAffineTransform moveBack = CGAffineTransformMakeTranslation(0, -300);
    [UIView animateWithDuration:duration animations:^{
        view.transform = bigger;
        view.transform = rotate;
        view.transform = smaller;
//        view.transform = move;
//        view.transform = moveBack;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

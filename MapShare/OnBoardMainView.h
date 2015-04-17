//
//  OnBoardMainView.h
//  MapShare
//
//  Created by Ethan Hess on 4/15/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundController.h"

@interface OnBoardMainView : UIViewController

@property (nonatomic, strong) UILabel *welcomeLabel;
@property (nonatomic, strong) UILabel *mapTypeLabel;
@property (nonatomic, strong) UILabel *searchLabel;
@property (nonatomic, strong) UILabel *clearAllLabel;
@property (nonatomic, strong) UILabel *shareLabel;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SoundController *soundController;

@end

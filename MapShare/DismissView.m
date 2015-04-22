//
//  DismissView.m
//  MapShare
//
//  Created by Ethan Hess on 4/14/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "DismissView.h"
#import "UIColor+UIColorCategory.h"

@implementation DismissView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stoneGray"]];
        
        self.dismissButton = [UIButton new];
        self.dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.dismissButton setTitle:@" Dismiss " forState:UIControlStateNormal];
        self.dismissButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:22];
        [self.dismissButton setBackgroundColor:[UIColor awesome]];
        [self.dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.dismissButton];
      
//        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_dismissButton);
        
//        NSArray *layoutConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_dismissButton(==50)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewDictionary];
//        
//        NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_dismissButton(<=150)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewDictionary];
        
        NSLayoutConstraint *vertical = [NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        
        NSLayoutConstraint *horizontal = [NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
        
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150.0];
        
        [self addConstraint:vertical];
        [self addConstraint:horizontal];
        [self addConstraint:height];
        [self addConstraint:width];

//        [self addConstraints:layoutConstraints];
//        [self addConstraints:horizontalConstraints];
        
        
        
        
    }
    
    return self;
    
}


@end

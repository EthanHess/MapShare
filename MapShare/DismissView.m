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
        
//        self.backgroundColor = [UIColor backgroundColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackstone"]];
        
        self.dismissButton = [UIButton new];
        self.dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.dismissButton setTitle:@" Dismiss " forState:UIControlStateNormal];
        self.dismissButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:18];
        [self.dismissButton setBackgroundColor:[UIColor awesome]];
        [self.dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.dismissButton];
        
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_dismissButton);
        
        NSArray *layoutConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_dismissButton(==50)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewDictionary];
        
        NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-32-[_dismissButton(==150)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewDictionary];

        [self addConstraints:layoutConstraints];
        [self addConstraints:horizontalConstraints];
        
        
    }
    
    return self;
    
}


@end

//
//  CalloutView.m
//  MapShare
//
//  Created by Ethan Hess on 4/9/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "CalloutView.h"
#import "UIColor+UIColorCategory.h"
#import "LocationController.h"

@implementation CalloutView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.removeButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 60, 35)];
        [self.removeButton setTitle:@" Delete " forState:UIControlStateNormal];
        [self.removeButton setBackgroundColor:[UIColor awesome]];
        [self.removeButton.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:12]];
        [self.removeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.removeButton addTarget:self action:@selector(removeLocation) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.removeButton];
        
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 55, 60, 35)];
        [self.cancelButton setTitle:@" Cancel " forState:UIControlStateNormal];
        [self.cancelButton setBackgroundColor:[UIColor awesome]];
        [self.cancelButton.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:12]];
        [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];
    }
    
    return self;
    
}

- (void)removeLocation {
    
    [[LocationController sharedInstance] removeLocation:self.location];
    
}

- (void)cancel {
    
    [self setHidden:YES];
}


@end

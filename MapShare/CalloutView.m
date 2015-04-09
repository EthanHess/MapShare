//
//  CalloutView.m
//  MapShare
//
//  Created by Ethan Hess on 4/9/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "CalloutView.h"
#import "UIColor+UIColorCategory.h"

@implementation CalloutView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.removeButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
        [self.removeButton setTitle:@" Delete " forState:UIControlStateNormal];
        [self.removeButton setBackgroundColor:[UIColor awesome]];
        [self.removeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.removeButton addTarget:self action:@selector(removeLocation) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.removeButton];
        
    }
    
    return self;
    
}

- (void)removeLocation {
    
    
    
}


@end

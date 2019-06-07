//
//  ColorCell.m
//  MapShare
//
//  Created by Ethan Hess on 12/27/18.
//  Copyright © 2018 Ethan Hess. All rights reserved.
//

#import "ColorCell.h"

@implementation ColorCell

- (void)animateWithDuration:(NSTimeInterval)duration andColor:(UIColor *)color {
    if (self.colorCircle == nil) {
        self.colorCircle = [[UIView alloc]initWithFrame:CGRectZero];
    }
    self.colorCircle.backgroundColor = color;
    self.colorCircle.layer.masksToBounds = YES;
    [self.contentView addSubview:self.colorCircle];
    [UIView animateWithDuration:duration animations:^{
        self.colorCircle.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 20);
        self.colorCircle.layer.cornerRadius = self.colorCircle.frame.size.width / 2;
    }];
}

@end

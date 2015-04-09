//
//  SearchButton.m
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "SearchButton.h"

@implementation SearchButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        [self setBackgroundImage:[UIImage imageNamed:@"CustomButton"] forState:UIControlStateNormal];
        [self.layer setCornerRadius:frame.size.width/2.0];
    }
    return self;
}

@end

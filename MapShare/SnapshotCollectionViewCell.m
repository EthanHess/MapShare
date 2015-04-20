//
//  SnapshotCollectionViewCell.m
//  MapShare
//
//  Created by Ethan Hess on 4/20/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "SnapshotCollectionViewCell.h"

@implementation SnapshotCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    
    CGFloat backViewHeight = (self.frame.size.height / 4);
    CGFloat viewHeight = self.frame.size.height;
    CGFloat viewWidth = self.frame.size.width;
    
    self.footerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight - backViewHeight, viewWidth, backViewHeight)];
    self.footerLabel.numberOfLines = 0;
    self.footerLabel.textColor = [UIColor whiteColor];
    [self.footerLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:self.footerLabel];
    
}

@end

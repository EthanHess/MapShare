//
//  SearchButton.m
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "SearchButton.h"
#import "UIColor+UIColorCategory.h"

@interface SearchButton ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation SearchButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self setBackgroundColor:[UIColor customCyan]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitle:@"GO" forState:UIControlStateNormal];
        
        self.layer.masksToBounds = YES;
        
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.strokeColor = [UIColor darkGrayColor].CGColor;
        _circleLayer.lineWidth = 3.0;
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        
        [self.layer insertSublayer:_circleLayer atIndex:(unsigned int)self.layer.sublayers.count];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateRadius:self.bounds];
}

- (void)updateRadius:(CGRect)rect {
    
    self.layer.cornerRadius = MAX(CGRectGetHeight(rect), CGRectGetWidth(rect)) / 2.0f;
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGRect zeroRectWithSize = { CGPointZero, rect.size };
    CGPathAddEllipseInRect(circlePath, NULL, zeroRectWithSize);
    _circleLayer.path = circlePath;
    
    CGPathRelease(circlePath);
}

@end

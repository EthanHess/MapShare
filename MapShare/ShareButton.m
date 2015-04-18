//
//  ShareButton.m
//  MapShare
//
//  Created by Ethan Hess on 4/17/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "ShareButton.h"

@interface ShareButton ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation ShareButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor greenColor]];
        
        [self setBackgroundImage:[UIImage imageNamed:@"customShareButton"] forState:UIControlStateNormal];
        
        self.layer.masksToBounds = YES;
        
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.strokeColor = [UIColor blueColor].CGColor;
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

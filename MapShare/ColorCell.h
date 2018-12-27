//
//  ColorCell.h
//  MapShare
//
//  Created by Ethan Hess on 12/27/18.
//  Copyright © 2018 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorCell : UICollectionViewCell

@property (nonatomic, strong) UIView *colorCircle;

- (void)animateWithDuration:(NSTimeInterval)duration andColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END

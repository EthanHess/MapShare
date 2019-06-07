//
//  UIColor+UIColorCategory.h
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColorCategory)

//App
+ (UIColor *)backgroundColor;
+ (UIColor *)awesome;
+ (UIColor *)toolbarBackground;
+ (UIColor *)lightBlueColor;
+ (UIColor *)borderColor;
+ (UIColor *)goldColor;
+ (UIColor *)darkBlueColor;
+ (UIColor *)instructionsBackground;
+ (UIColor *)snapYellow;

//+ (UIColor *)snapOrange;
//+ (UIColor *)snapBlue;
//+ (UIColor *)snapPurple;
//+ (UIColor *)snapTan;

//Custom markers
+ (UIColor *)customYellow; //For index path 0 of collection view
+ (UIColor *)customOrange;
+ (UIColor *)customCyan;
+ (UIColor *)customBlack;
+ (UIColor *)customGray;
+ (UIColor *)customWhite;
+ (UIColor *)customPurple;
+ (UIColor *)customBrown;

@end

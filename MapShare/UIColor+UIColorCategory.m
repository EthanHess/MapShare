//
//  UIColor+UIColorCategory.m
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "UIColor+UIColorCategory.h"

@implementation UIColor (UIColorCategory)

+ (UIColor *)backgroundColor {
    return [UIColor colorWithRed:(35/255.0) green:(170/255.0) blue:(150/255.0) alpha:1.0];
}

+ (UIColor *)awesome {
    return [UIColor colorWithRed:(0/255.0) green:(150/255.0) blue:(180/255.0) alpha:1.0];
}

+ (UIColor *)toolbarBackground {
    return [UIColor colorWithRed:(15/255.0) green:(200/255.0) blue:(90/255.0) alpha:1.0];
}

+ (UIColor *)lightBlueColor {
    return [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(95/255.0) alpha:1.0];
}

+ (UIColor *)borderColor {
    return [UIColor colorWithRed:(25/255.0) green:(45/255.0) blue:(10/255.0) alpha:1.0];
}

+ (UIColor *)goldColor {
    return [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:32.0f/255.0f alpha:1.0];
}

+ (UIColor *)darkBlueColor {
    return [UIColor colorWithRed:24.0f/255.0f green:43.0f/255.0f blue:255.0f/255.0f alpha:1.0];
}

+ (UIColor *)instructionsBackground {
    return [UIColor colorWithRed:196.0f/255.0f green:230.0f/255.0f blue:237.0f/255.0f alpha:1.0];
}

+ (UIColor *)snapYellow {
    return [UIColor colorWithRed:216.0f/255.0f green:212.0f/255.0f blue:37.0f/255.0f alpha:1.0];
}

//+ (UIColor *)snapOrange {

//}

//+ (UIColor *)snapBlue {

//}

//+ (UIColor *)snapPurple {

//}

//+ (UIColor *)snapTan {

//}

//TODO: Remove most of these and add custom collection view colors

+ (UIColor *)customYellow {
    return [UIColor colorWithRed:249.0f/255.0f green:247.0f/255.0f blue:184.0f/255.0f alpha:1.0];
}

+ (UIColor *)customOrange {
    return [UIColor colorWithRed:253.0f/255.0f green:188.0f/255.0f blue:125.0f/255.0f alpha:1.0];
}

+ (UIColor *)customCyan {
    return [UIColor colorWithRed:184.0f/255.0f green:249.0f/255.0f blue:242.0f/255.0f alpha:1.0];
}

+ (UIColor *)customBlack {
    return [UIColor colorWithRed:8.0f/255.0f green:44.0f/255.0f blue:40.0f/255.0f alpha:1.0];
}

+ (UIColor *)customGray {
    return [UIColor colorWithRed:138.0f/255.0f green:141.0f/255.0f blue:141.0f/255.0f alpha:1.0];
}

+ (UIColor *)customWhite {
    return [UIColor colorWithRed:244.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0];
}

+ (UIColor *)customPurple {
    return [UIColor colorWithRed:204.0f/255.0f green:176.0f/255.0f blue:251.0f/255.0f alpha:1.0];
}

+ (UIColor *)customBrown {
    return [UIColor colorWithRed:95.0f/255.0f green:81.0f/255.0f blue:66.0f/255.0f alpha:1.0];
}


@end

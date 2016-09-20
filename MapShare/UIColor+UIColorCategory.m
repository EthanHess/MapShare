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

//TODO: Remove most of these and add custom collection view colors

@end

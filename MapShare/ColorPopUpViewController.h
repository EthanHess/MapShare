//
//  ColorPopUpViewController.h
//  MapShare
//
//  Created by Ethan Hess on 12/15/18.
//  Copyright © 2018 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorChosenDelegate <NSObject>
- (void)didChooseColor:(UIColor *)color;
@end

@interface ColorPopUpViewController : UIViewController

@property (nonatomic, weak) id <ColorChosenDelegate> delegate;

@end

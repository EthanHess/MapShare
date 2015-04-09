//
//  CalloutView.h
//  MapShare
//
//  Created by Ethan Hess on 4/9/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface CalloutView : UIView

@property (nonatomic, strong) UIButton *removeButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) Location *location;

@end

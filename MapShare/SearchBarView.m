//
//  SearchBarView.m
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "SearchBarView.h"
#import "UIColor+UIColorCategory.h"

#define IS_IPHONE_4 ([UIScreen mainScreen].bounds.size.width == 320.0)

@implementation SearchBarView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        self.searchBar = [UISearchBar new];
        self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
//        self.searchBar.delegate = self;
        self.searchBar.placeholder = @" Search Location ";
        [self addSubview:self.searchBar];
        
        self.button = [SearchButton new];
        self.button.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.button];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_searchBar, _button);
        
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_searchBar(==60)]" options:0 metrics:nil views:viewsDictionary];
        
        NSLayoutConstraint *equalConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.searchBar attribute:NSLayoutAttributeHeight multiplier:1 constant:0.0];
        
        if (IS_IPHONE_4) {
            
            NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[_searchBar(==190)]-20-[_button(==60)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
            
            [self addConstraints:horizontalConstraints];
        }
        
        NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[_searchBar(==225)]-20-[_button(==60)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
        
        [self addConstraints:constraints];
        [self addConstraints:horizontalConstraints];
        [self addConstraint:equalConstraint]; 
    }
        
    return self;
}


@end

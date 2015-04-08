//
//  SearchBarView.m
//  MapShare
//
//  Created by Ethan Hess on 4/8/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "SearchBarView.h"
#import "UIColor+UIColorCategory.h"

@implementation SearchBarView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor backgroundColor];
        
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 15, self.frame.size.width - 70, self.frame.size.height - 50)];
        self.searchBar.delegate = self;
        self.searchBar.placeholder = @" Search Location ";
        [self addSubview:self.searchBar];
        
        
    }
        
    return self;
}

@end

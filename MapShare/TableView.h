//
//  TableView.h
//  MapShare
//
//  Created by Ethan Hess on 4/13/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

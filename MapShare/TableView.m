//
//  TableView.m
//  MapShare
//
//  Created by Ethan Hess on 4/13/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "TableView.h"
#import "ViewController.h"

@implementation TableView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView = [[UITableView alloc]initWithFrame:self.bounds];
        [self addSubview:self.tableView];
        
        
    }
    
    return self;
    
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}


@end

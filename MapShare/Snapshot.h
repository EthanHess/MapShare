//
//  Snapshot.h
//  MapShare
//
//  Created by Ethan Hess on 4/20/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Snapshot : NSManagedObject

@property (nonatomic, retain) NSData * snapshot;
@property (nonatomic, retain) NSString * caption;

@end

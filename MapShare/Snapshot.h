//
//  Snapshot.h
//  MapShare
//
//  Created by Ethan Hess on 4/17/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Snapshot : NSManagedObject

@property (nonatomic, retain) NSData * snapshot;

@end

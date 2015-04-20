//
//  SnapshotController.m
//  MapShare
//
//  Created by Ethan Hess on 4/17/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "SnapshotController.h"
#import "Stack.h"

@implementation SnapshotController

+ (SnapshotController *)sharedInstance {
    static SnapshotController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [SnapshotController new];
    });
    
    return sharedInstance;
    
}

- (NSArray *)snapshots {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Snapshot"];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
    
}

- (void)addSnapshotWithImage:(UIImage *)image caption:(NSString *)caption {
    
    NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(image, 100)];
    
    Snapshot *snapshot = [NSEntityDescription insertNewObjectForEntityForName:@"Snapshot" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    snapshot.snapshot = data;
    snapshot.caption = caption;
    
    [self synchronize];
    
    
}

- (void)removeSnapshots:(Snapshot *)snapshot {
    
    [snapshot.managedObjectContext deleteObject:snapshot];
    
    [self synchronize];
    
}

- (void)synchronize {
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
}


@end

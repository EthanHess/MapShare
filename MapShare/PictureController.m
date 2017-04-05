//
//  PictureController.m
//  MapShare
//
//  Created by Ethan Hess on 8/27/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "PictureController.h"
@import CoreData;
#import "Stack.h"

@implementation PictureController

+ (PictureController *)sharedInstance {
    static PictureController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PictureController new];
    });
    
    return sharedInstance;
    
}

- (NSArray *)pictures {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Picture"];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
}

- (void)addPicture:(UIImage *)image {
    
    NSData *data = [self imageToData:image];
    
    Picture *picture = [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    picture.picData = data;
    
    [self synchronize]; 
}

- (void)removePicture:(Picture *)picture {
    
    [[picture managedObjectContext]deleteObject:picture];
    
    [self synchronize]; 
}

- (NSData *)imageToData:(UIImage *)image {
    
    return [NSData dataWithData:UIImageJPEGRepresentation(image, 1)];
}

- (void)synchronize {
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
}


@end

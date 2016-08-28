//
//  PictureController.h
//  MapShare
//
//  Created by Ethan Hess on 8/27/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
@import UIKit;

@interface PictureController : NSObject

@property (nonatomic, strong) NSArray *pictures;

+ (PictureController *)sharedInstance;

- (void)addPicture:(UIImage *)image;

- (void)removePicture:(Picture *)picture;

@end

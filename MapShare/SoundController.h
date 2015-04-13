//
//  SoundController.h
//  MapShare
//
//  Created by Ethan Hess on 4/13/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundController : NSObject

+ (void)playSoundWithName:(NSString *)soundName;
+ (void)playAlertWithName:(NSString *)alertName;
+ (void)playSoundWithFile:(NSString *)fileName type:(NSString *)fileType alert:(BOOL)alert;


@end

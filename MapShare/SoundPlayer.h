//
//  SoundPlayer.h
//  MapShare
//
//  Created by Ethan Hess on 4/14/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundPlayer : NSObject

+ (void)playSoundWithName:(NSString *)soundName;
+ (void)playSoundWithFile:(NSString *)fileName type:(NSString *)fileType alert:(BOOL)alert;

@end


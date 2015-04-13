//
//  SoundController.m
//  MapShare
//
//  Created by Ethan Hess on 4/13/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "SoundController.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation SoundController

+ (void)playSoundWithName:(NSString *)soundName {
    [self playSoundWithFile:soundName type:nil alert:NO];
}

+ (void)playAlertWithName:(NSString *)alertName {
    [self playSoundWithFile:alertName type:nil alert:YES];
}

+ (void)playSoundWithFile:(NSString *)fileName type:(NSString *)fileType alert:(BOOL)alert {
    if (!fileType) {
        fileType = @"caf";
    }
    SystemSoundID soundID;
    NSString *soundFile = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:soundFile], &soundID);
    
    if (alert) {
        AudioServicesPlayAlertSound(soundID);
    } else {
        AudioServicesPlaySystemSound(soundID);
    }
}


@end

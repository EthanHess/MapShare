//
//  SoundController.m
//  MapShare
//
//  Created by Ethan Hess on 4/13/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "SoundController.h"

@interface SoundController ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation SoundController

- (void)playAudioFileAtURL:(NSURL *)url {
    
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    self.player.numberOfLoops = 0;
    [self.player play];
}

@end

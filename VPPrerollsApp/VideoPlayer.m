//
//  VideoPlayer.m
//  iOS_Ads_Thingy
//
//  Created by Mikael on 27/10/14.
//  Copyright (c) 2014 Mikael. All rights reserved.
//

#import "VideoPlayer.h"

@implementation VideoPlayer

- (id) initWithFrame:(CGRect)frame andContentURl:(NSURL*) url {
    if (self = [super initWithFrame:frame]) {
        self.listener = nil;
        contentUrl = url;
        videoView = frame;
    }
    return self;
}

#pragma Setup player

- (void) setupPlayer {
    videoPlayer = [MPMoviePlayerController new];
    [videoPlayer setContentURL:contentUrl];
    [videoPlayer.view setFrame:videoView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentPlaybackDone:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayer];
    [videoPlayer setControlStyle:MPMovieControlStyleFullscreen];
    [self addSubview:videoPlayer.view];
    [videoPlayer prepareToPlay];
}

#pragma Handle player

- (void) contentPlaybackDone:(NSNotification*) note {
    MPMoviePlayerController* cont = [note object];
    NSNumber* reason = [note userInfo][MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    switch ([reason integerValue]) {
        case MPMovieFinishReasonPlaybackEnded:
            [self removePlayer:cont];
            [self.listener removeZePlayer];
            break;
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"An error was encountered during playback");
            [self performSelectorOnMainThread:@selector(displayError:) withObject:[note userInfo][@"error"]
                                waitUntilDone:NO];
            [self removePlayer:cont];
            [self.listener removeZePlayer];
            break;
        case MPMovieFinishReasonUserExited:
            [self removePlayer:cont];
            [self.listener removeZePlayer];
            break;
        default:
            break;
    }
}

#pragma Handle Errors

- (void) displayError:(NSError*) error {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error"
                              message: [error localizedDescription]
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

// remove the player

- (void) removePlayer:(MPMoviePlayerController*) controller {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:controller];
    [controller stop];
    controller.initialPlaybackTime = -1;
    [controller.view removeFromSuperview];
    controller = nil;
}

// if player is not prescent create it else play

- (void) playMe {
    if (!videoPlayer) {
        [self setupPlayer];
    }
    else {
        [videoPlayer prepareToPlay];
    }
}

@end

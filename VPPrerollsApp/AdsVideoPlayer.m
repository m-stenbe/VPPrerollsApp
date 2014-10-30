//
//  AdsVideoPlayer.m
//  iOS_Ads_Thingy
//
//  Created by Mikael on 29/10/14.
//  Copyright (c) 2014 Mikael. All rights reserved.
//

#import "AdsVideoPlayer.h"
#import <VPPreRolls/AdTracking.h>
#import <VPPreRolls/MediaFile.h>

@implementation AdsVideoPlayer

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.listener = nil;
        adsFrame = frame;
    }
    return self;
}

#pragma Setups

- (UIView*) setupClickThroughView {
    clickThroughView = [[UIView alloc] initWithFrame:adsFrame];
    clickAdGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(theClickThroughUrl)];
    [clickThroughView addGestureRecognizer:clickAdGr];
    return clickThroughView;
}

- (void) setupPlayer {
    adsPlayer = [MPMoviePlayerController new];
    NSString* cdata = @"";
    mediaFile = [MediaFile new];
    NSMutableArray* arr = [NSMutableArray arrayWithArray:[mediaFile getMediaFiles]];
    for (MediaFile* m in arr) {
        cdata = [m cdata];
    }
    [adsPlayer setContentURL:[NSURL URLWithString:cdata]];
    [self.listener setZeAdsPlayer:adsPlayer];
    [adsPlayer.view setFrame:adsFrame];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adsPlaybackDone:) name:MPMoviePlayerPlaybackDidFinishNotification object:adsPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeMediaPlayer) name:UIApplicationDidBecomeActiveNotification object:nil];
    [adsPlayer setControlStyle:MPMovieControlStyleNone];
    [self addSubview:adsPlayer.view];
    [self addSubview:[self setupClickThroughView]];
    [adsPlayer prepareToPlay];
}

- (void) theClickThroughUrl {
    adTracking = [AdTracking new];
    [adTracking adClicked];
}

#pragma Handle AdsPlayerFinshed

- (void) adsPlaybackDone:(NSNotification*) note {
    MPMoviePlayerController* cont = [note object];
    NSNumber* reason = [note userInfo][MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    switch ([reason integerValue]) {
        case MPMovieFinishReasonPlaybackEnded:
            [self removePlayer:cont];
            [self.listener removeZeAdsPlayer];
            break;
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"An error was encountered during playback");
            [self performSelectorOnMainThread:@selector(displayError:) withObject:[note userInfo][@"error"]
                                waitUntilDone:NO];
            [self removePlayer:cont];
            [self.listener removeZeAdsPlayer];
            break;
        case MPMovieFinishReasonUserExited:
            [self removePlayer:cont];
            [self.listener removeZeAdsPlayer];
            break;
        default:
            break;
    }
}

- (void) resumeMediaPlayer {
    [adsPlayer play];
}

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
- (void) playAdsMe {
    if (!adsPlayer) {
        [self setupPlayer];
    }
    else {
        [adsPlayer prepareToPlay];
    }
}

@end

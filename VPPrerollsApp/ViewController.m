//
//  ViewController.m
//  iOS_Preroll
//
//  Created by Mikael on 30/10/14.
//  Copyright (c) 2014 MS. All rights reserved.
//

#import "ViewController.h"
#import <VPPreRolls/AdTracking.h>
#import <VPPreRolls/InitTicket.h>

#define MOVIEURL @"http://download.wavetlan.com/SVV/Media/HTTP/sample_100kbit.mp4"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    InitTicket* ticket = [InitTicket new];
    [ticket initXmlFile];
}

- (IBAction)playMe:(id)sender {
    [self playAds];
}

- (void) playAds {
    adsPlayer = [[AdsVideoPlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [adsPlayer setListener:self];
    [self.view addSubview:adsPlayer];
    [adsPlayer playAdsMe];
}

- (void) playMainContent{
    player = [[VideoPlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) andContentURl:[NSURL URLWithString:MOVIEURL]];
    player.listener = self;
    [self.view addSubview:player];
    [player playMe];
}

#pragma AdsVideoPlayerListeners

- (void)setZeAdsPlayer:(MPMoviePlayerController *)theController {
    mediaPlayer = theController;
}

- (void)removeZeAdsPlayer {
    AdTracking* tracking = [AdTracking new];
    [tracking adPlayed];
    [adsPlayer removeFromSuperview];
    [self playMainContent];
}

#pragma VideoPlayerListener

- (void)removeZePlayer {
    [player removeFromSuperview];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    }
    else {
        return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
}
@end

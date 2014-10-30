//
//  ViewController.h
//  iOS_Preroll
//
//  Created by Mikael on 30/10/14.
//  Copyright (c) 2014 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdsVideoPlayer.h"
#import "VideoPlayer.h"

@interface ViewController : UIViewController <AdsVideoPlayerListener, VideoPlayerListener> {
    MPMoviePlayerController* mediaPlayer;
    VideoPlayer* player;
    AdsVideoPlayer* adsPlayer;
}

- (IBAction)playMe:(id)sender;

@end


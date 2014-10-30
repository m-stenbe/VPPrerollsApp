//
//  AdsVideoPlayer.h
//  iOS_Ads_Thingy
//
//  Created by Mikael on 29/10/14.
//  Copyright (c) 2014 Mikael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class MediaFile;
@class AdTracking;

@protocol AdsVideoPlayerListener <NSObject>

@required
- (void) removeZeAdsPlayer;
- (void) setZeAdsPlayer:(MPMoviePlayerController*) theController;

@end

@interface AdsVideoPlayer : UIView {
    MPMoviePlayerController* adsPlayer;
    CGRect adsFrame;
    UIView* clickThroughView;
    UITapGestureRecognizer* clickAdGr;
    MediaFile* mediaFile;
    AdTracking* adTracking;
}

- (void) playAdsMe;
@property id<AdsVideoPlayerListener> listener;

@end

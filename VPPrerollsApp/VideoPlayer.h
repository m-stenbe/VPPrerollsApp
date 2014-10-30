//
//  VideoPlayer.h
//  iOS_Ads_Thingy
//
//  Created by Mikael on 27/10/14.
//  Copyright (c) 2014 Mikael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol VideoPlayerListener <NSObject>

@required
- (void) removeZePlayer;

@end

@interface VideoPlayer : UIView {
    MPMoviePlayerController* videoPlayer;
    NSURL* contentUrl;
    CGRect videoView;
}

- (void) playMe;
- (id) initWithFrame:(CGRect)frame andContentURl:(NSURL*) url;
@property id<VideoPlayerListener> listener;

@end

//
//  AdTracking.h
//  iOSAds
//
//  Created by Mikael on 30/10/14.
//  Copyright (c) 2014 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

//not used atm
//typedef enum {
//    TrackingEventMidpoint = 0,
//    TrackingEventComplete = 1,
//    TrackingEventStart = 2,
//    TrackingEventFirstQuartile = 3,
//    TrackingEventClose = 4,
//    TrackingEventsThirdQuartile = 5,
//} TrackingEvents;

@class Ticket;

@interface AdTracking : NSObject {
    @private
    NSString* clickThrough;
    NSString* clickTracking;
    NSString* trackingData;
    NSString* adUrl;
    NSString* error;
    Ticket* ticket;
    //TrackingEvents* events;
}

- (void) adClicked;
- (void) adPlayed;

@end

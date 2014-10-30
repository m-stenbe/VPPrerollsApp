//
//  MediaFile.h
//  iOS_Ads_Thingy
//
//  Created by Mikael on 27/10/14.
//  Copyright (c) 2014 Mikael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaFile : NSObject

@property (copy) NSString* delivery;
@property (copy) NSString* type;
@property (copy) NSString* bitrate;
@property (copy) NSString* width;
@property (copy) NSString* height;
@property (assign) BOOL scalable;
@property (copy) NSString* cdata;

- (NSArray*) getMediaFiles;

@end

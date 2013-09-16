//
//  Data.h
//  QueueHTTPUseDemo
//
//  Created by Taiping on 13-8-22.
//  Copyright (c) 2013年 刘彬彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject

@property(nonatomic, retain) NSString *hash;//
@property(nonatomic, retain) NSString *account_id; //
@property(nonatomic, retain) NSString *account_url;//
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *score;
@property(nonatomic, retain) NSString *starting_score;
@property(nonatomic, retain) NSString *virality;
@property(nonatomic, retain) NSString *size;
@property(nonatomic, retain) NSString *views;

@property(nonatomic, retain) NSString *is_hot;//
@property(nonatomic, retain) NSString *is_album;//
@property(nonatomic, retain) NSString *album_description;//
@property(nonatomic, retain) NSString *album_layout;//
@property(nonatomic, retain) NSString *album_cover;//
@property(nonatomic, retain) NSString *mimetype;//
@property(nonatomic, retain) NSString *nsfw;//
@property(nonatomic, retain) NSString *ext;//
@property(nonatomic, retain) NSString *width;
@property(nonatomic, retain) NSString *height;//
@property(nonatomic, retain) NSString *animated;//
@property(nonatomic, retain) NSString *ups;
@property(nonatomic, retain) NSString *downs;//
@property(nonatomic, retain) NSString *points;//
@property(nonatomic, retain) NSString *reddit;
@property(nonatomic, retain) NSString *bandwidth;//
@property(nonatomic, retain) NSString *timestamp;
@property(nonatomic, retain) NSString *hot_datetime;//
@property(nonatomic, retain) NSString *section;
@property(nonatomic, retain) NSString *description;//
@property(nonatomic, retain) NSString *favorited;//
@property(nonatomic, retain) NSString *vote;
@property(nonatomic, retain) NSString *album_privacy;
@end

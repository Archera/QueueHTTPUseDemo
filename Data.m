//
//  Data.m
//  QueueHTTPUseDemo
//
//  Created by Taiping on 13-8-22.
//  Copyright (c) 2013年 刘彬彬. All rights reserved.
//

#import "Data.h"

@implementation Data

@synthesize hash,account_id,account_url,title,score,starting_score,virality,size,views,is_hot;//
@synthesize is_album,album_cover,mimetype,nsfw,ext,width,height,animated,ups,downs,points;//
@synthesize reddit,bandwidth,timestamp,hot_datetime,section,description,favorited,vote, album_description,album_layout,album_privacy;

- (void)dealloc
{
    [album_privacy release];
    [hash release];
    [account_id release];
    [account_url release];
    [title release];
    [score release];
    [starting_score release];
    [virality release];
    [size release];
    [views release];
    [is_hot release];
    [is_album release];
    [album_cover release];
    [mimetype release];
    [nsfw release];
    [ext release];
    [width release];
    [height release];
    [animated release];
    [ups release];
    [downs release];
    [points release];
    [reddit release];
    [bandwidth release];
    [timestamp release];
    [hot_datetime release];
    [section release];
    [description release];
    [favorited release];
    [vote release];
    [ext release];
    [album_description release];
    [album_layout release];
        
    [super dealloc];
    
}

@end

//
//  HttpRequest.h
//  QueueHTTPUseDemo
//
//  Created by 刘彬彬 on 13-8-21.
//  Copyright (c) 2013年 刘彬彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "DataParse.h"

@protocol HttpRequestDelegate <NSObject>

- (void)httpRequestFinished:(NSArray*)dataArray;

@end

@interface HttpRequest : NSObject
{
    ASINetworkQueue *networkQueue;
    NSMutableArray *urlStrArray;
    DataParse *dataParse;
    id <HttpRequestDelegate>delegate;
}
@property (nonatomic,retain)  id <HttpRequestDelegate>delegate;
@property (nonatomic,retain)NSMutableArray *urlStrArray;
- (void)addQueue;
- (void)ASIFormDataRequestPostRequest;
@end

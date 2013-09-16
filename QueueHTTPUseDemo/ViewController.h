//
//  ViewController.h
//  QueueHTTPUseDemo
//
//  Created by 刘彬彬 on 13-8-16.
//  Copyright (c) 2013年 刘彬彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"

#import "HttpRequest.h"

@interface ViewController : UIViewController<HttpRequestDelegate>
{
    ASINetworkQueue *networkQueue;
    NSMutableArray *urlStrArray;
    HttpRequest *httpRequest;
    NSArray *objectArray;
}
@property (nonatomic,retain)NSMutableArray *urlStrArray;
@property (nonatomic,retain)NSArray *objectArray;
@end

//
//  HttpRequest.m
//  QueueHTTPUseDemo
//
//  Created by 刘彬彬 on 13-8-21.
//  Copyright (c) 2013年 刘彬彬. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest
@synthesize urlStrArray = _urlStrArray;
@synthesize delegate = _delegate;
- (void)dealloc
{
    [_delegate release];
    [_urlStrArray release];
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        self.urlStrArray = tempArray;
        [tempArray release];
    }
    return self;
}

#pragma mark -- request
- (ASIHTTPRequest*)initRequest:(NSString*)urlStr withIndex:(int)index
{
    ASIHTTPRequest *request;
	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    //定义request的文件保存路径
	[request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"1.zip"]];
    //设置是否支持断点下载
    [request setAllowResumeForFileDownloads:NO];
    NSString *key = [NSString stringWithFormat:@"%d",index];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request1" forKey:key]];
    return request;
}

#pragma mark -- 队列
- (void)addQueue
{
    if (!networkQueue)
    {
		networkQueue = [[ASINetworkQueue alloc] init];
	}
    
    [networkQueue reset];
    //当一个request失败的时候，不会取消所有的request，默认是取消所有
    [networkQueue setShouldCancelAllRequestsOnFailure:NO];
	[networkQueue setRequestDidFinishSelector:@selector(requsetFetchComplete:)];
	[networkQueue setRequestDidFailSelector:@selector(requsetFetchFailed:)];
	[networkQueue setDelegate:self];
    
    //add request
    for (int i = 0; i<self.urlStrArray.count; i++)
    {
        [networkQueue addOperation:[self initRequest:[self.urlStrArray objectAtIndex:i] withIndex:i]];
    }
    [networkQueue go];
}

#pragma mark -- ASINetworkQueue回调事件
- (void)requsetFetchComplete:(ASIHTTPRequest *)request
{
    NSError *error;
    //根据key获得标示的request，触发对应的事件
    if ([request.userInfo objectForKey:@"0"])
    {
        //暂停请求
        //[request clearDelegatesAndCancel];
        NSString *dataString = [request downloadDestinationPath];
        NSString *demoStr1 = [NSString stringWithContentsOfFile:dataString encoding:NSUTF8StringEncoding error:&error];
        NSLog(@"%@",demoStr1);
        
        //解析json
        NSData *jsonData = [NSData dataWithContentsOfFile:dataString];
        dataParse = [[DataParse alloc] init];
        [dataParse setObjectData:jsonData];
        NSArray *tempArray = [NSArray array];
        tempArray = [dataParse jsonDataToNSObject:@"data"];
        [dataParse release];
        if (tempArray.count!=0)
        {
            //[delegate respondsToSelector:@selector(httpRequestFinished:)];
            [_delegate httpRequestFinished:tempArray];
        }
        else
        {}
        
    }
    else if ([request.userInfo objectForKey:@"1"])
    {
        //[request clearDelegatesAndCancel];
        NSString *dataString = [request downloadDestinationPath];
        NSString *demoStr1 = [NSString stringWithContentsOfFile:dataString encoding:NSUTF8StringEncoding error:&error];
        NSLog(@"%@",demoStr1);
        //解析xml
        NSData *jsonData = [NSData dataWithContentsOfFile:dataString options:NSDataReadingMappedIfSafe error:&error];
        dataParse = [[DataParse alloc] init];
        [dataParse setObjectData:jsonData];
        [dataParse release];
        
    }
    else
    {
    }
}

#pragma mark -- 队列取消方法
- (void)cancelRequest
{
    [networkQueue cancelAllOperations];
}

- (void)requsetFetchFailed:(ASIHTTPRequest *)request
{
    NSLog(@"------error------");
}

#pragma mark -- ASIFormDataRequest post请求
- (void)ASIFormDataRequestPostRequest
{
    //开启iphone网络开关
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://10.7.204.37/HttpRequest/service"]];
    //超时时间
    request.timeOutSeconds = 30;
    
    request.delegate = self;
    
    //定义异步方法
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestDidFailed:)];
    [request setDidFinishSelector:@selector(requestDidSuccess:)];
    
    //用户自定义数据   字典类型  （可选）
//    request.userInfo = [NSDictionary dictionaryWithObject:nil forKey:@"Method"];
    //post的数据
    
    //[request appendPostData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"22",@"33", nil];
    [request setPostValue:array forKey:@"key"];
    [array release];
    //开始执行
    
    [request startAsynchronous];
}

#pragma mark -- ASIFormDataRequest 回调事件
- (void)requestDidSuccess:(ASIHTTPRequest*)request
{
    [delegate respondsToSelector:@selector(success:)];
}

- (void)requestDidFailed:(ASIHTTPRequest*)request
{
    //获取的用户自定义内容
    NSString *method = [request.userInfo objectForKey:@"Method"];
    //获取错误数据
    NSError *error = [request error];
}

@end

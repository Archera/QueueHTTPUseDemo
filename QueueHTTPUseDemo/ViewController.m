//
//  ViewController.m
//  QueueHTTPUseDemo
//
//  Created by 刘彬彬 on 13-8-16.
//  Copyright (c) 2013年 刘彬彬. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize urlStrArray = _urlStrArray;
@synthesize objectArray = _objectArray;
- (void)dealloc
{
    [_objectArray release];
    [_urlStrArray release];
    [super dealloc];
}

- (void)initData
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:@"http://imgur.com/gallery.json",@"http://imgur.com/gallery.xml",@"http://davidphotos.sinaapp.com/photos/reqPhotos/?from=0&count=2", nil];
    self.urlStrArray = tempArray;
    [tempArray release];
    
    NSArray *temp = [[NSArray alloc] init];
    self.objectArray = temp;
    [temp release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initData];
//    [self addQueue];
    httpRequest = [[HttpRequest alloc] init];
    httpRequest.delegate = self;
//    [httpRequest ASIFormDataRequestPostRequest];
    [httpRequest setUrlStrArray:self.urlStrArray];
    [httpRequest addQueue];
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
    }
    else if ([request.userInfo objectForKey:@"1"])
    {
        //[request clearDelegatesAndCancel];
        NSString *dataString = [request downloadDestinationPath];
        NSString *demoStr1 = [NSString stringWithContentsOfFile:dataString encoding:NSUTF8StringEncoding error:&error];
        NSLog(@"%@",demoStr1);
    }
    else if ([request.userInfo objectForKey:@"2"])
    {
        NSString *dataString = [request downloadDestinationPath];
        NSString *demoStr2 = [NSString stringWithContentsOfFile:dataString encoding:NSUTF8StringEncoding error:&error];
        NSLog(@"demoStr2 ＝ %@",demoStr2);
    }
}

- (void)requsetFetchFailed:(ASIHTTPRequest *)request
{
    NSLog(@"------error------");
}

#pragma mark -- 队列取消方法
- (void)cancelRequest
{
    [networkQueue cancelAllOperations];
}

#pragma mark -- http返回值
- (void)httpRequestFinished:(NSArray*)dataArray
{
    //获得对象集合
    NSLog(@"%d",dataArray.count);
    if (dataArray.count!=0)
    {
        self.objectArray = dataArray;
        //将对象转换成json
        [self objectChangeToJson:self.objectArray];
    }
}

#pragma mark -- 将对象转换成json
- (void)objectChangeToJson:(NSArray*)jsonArray
{
    DataParse *dataParse = [[DataParse alloc] init];
    [dataParse setDataItems:jsonArray];
    [dataParse objectToJson];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

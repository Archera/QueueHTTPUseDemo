//
//  DataParse.h
//  QueueHTTPUseDemo
//
//  Created by 刘彬彬 on 13-8-21.
//  Copyright (c) 2013年 刘彬彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <Foundation/NSObjCRuntime.h>
#import "SHXMLParser.h"
#import "JSONAutoSerializer.h"
@interface DataParse : NSObject
{
    NSArray	*dataItems;
    NSData *objectData;
}
@property (nonatomic, retain) NSArray *dataItems;
@property (nonatomic, retain) NSData *objectData;

- (NSArray*)jsonDataToNSObject:(NSString*)className;
- (void)xmlDataToNSObject:(NSString*)className;
- (void)objectToJson;
@end

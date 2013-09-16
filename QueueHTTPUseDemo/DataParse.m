//
//  DataParse.m
//  QueueHTTPUseDemo
//
//  Created by 刘彬彬 on 13-8-21.
//  Copyright (c) 2013年 刘彬彬. All rights reserved.
//

#import "DataParse.h"

@implementation DataParse
@synthesize dataItems=_dataItems;
@synthesize objectData=_objectData;

- (void)dealloc
{
    [_objectData release];
    [_dataItems release];
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        NSArray *tempArray = [[NSArray alloc] init];
        self.dataItems = tempArray;
        [tempArray release];
        
        NSData *tempData = [[NSData alloc] init];
        self.objectData = tempData;
        [tempData release];
    }
    return self;
}

#pragma mark -- 将jsondata转换成object 
- (NSArray*)jsonDataToNSObject:(NSString*)className
{
    NSError *error;
	NSDictionary *resultObject	=  [NSJSONSerialization JSONObjectWithData:self.objectData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"%@",resultObject);
    //类名
    //NSString *className = NSStringFromClass([object class]);
    NSArray *classArray = [resultObject objectForKey:className];
    NSLog(@"%d",classArray.count);
    
    //拿到object对应的所有属性名
    NSMutableArray *classVariables = [self objectPropertyNames:[className capitalizedString]];
    NSLog(@"%d",classVariables.count);
    
    //获取对象集合
    self.dataItems = [SHXMLParser convertDictionaryArray:classArray toObjectArrayWithClassName:[className capitalizedString] classVariables:classVariables];
    NSLog(@"%d",self.dataItems.count);
    return self.dataItems;
}

#pragma mark -- 将xml转换成object
- (void)xmlDataToNSObject:(NSString*)className
{
    SHXMLParser		*parser			= [[SHXMLParser alloc] init];
	NSDictionary	*resultObject	= [parser parseData:self.objectData];
    NSLog(@"%@",resultObject);
    NSArray	*dataArray = [SHXMLParser getDataAtPath:className fromResultObject:resultObject];
    //拿到object对应的所有属性名
    NSMutableArray *classVariables = [self objectPropertyNames:[className capitalizedString]];
    //获取对象集合
    self.dataItems = [SHXMLParser convertDictionaryArray:dataArray toObjectArrayWithClassName:[className capitalizedString] classVariables:classVariables];
    NSLog(@"%d",self.dataItems.count);
}

#pragma mark -- 将object转换成xml
- (void)objectToXML
{}

#pragma mark -- 将object转换成json
- (void)objectToJson
{
    for (int i=0; i<self.dataItems.count; i++)
    {
        id object = [self.dataItems objectAtIndex:i];
        NSString *jsonString = [[JSONAutoSerializer sharedSerializer] serializeObject:object];

        NSLog(@"jsonString = %@",jsonString);
    }
}

#pragma mark -- 获取对象的属性名
- (NSMutableArray*)objectPropertyNames:(NSString*)className
{
    const char*cClassName = [className UTF8String];
    id theClass =  objc_getClass(cClassName);
    
    unsigned int outCount, j;
    //获取当前实体类中所有属性名
    objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
    
    NSMutableArray *propertyNames = [NSMutableArray array];
    for (j = 0; j < outCount; j++)
    {
        objc_property_t property = properties[j];
        
        //property_getName()返回属性的名字 在CodeClass中分别是 Code和Name,Classes
        //property_getAttributes()返回属性的属性，如是retain还是copy之类的
        
        //这个方法输出了该类所有的属性名与对应的属性的属性
        NSLog(@"%s %s\n", property_getName(property), property_getAttributes(property));
        NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSLog(@"%@",propertyNameString);
        [propertyNames addObject:propertyNameString];
        [propertyNameString release];
    }
    return propertyNames;
}
@end

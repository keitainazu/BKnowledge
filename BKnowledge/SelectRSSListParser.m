//
//  SelectRSSListParser.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/13.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "SelectRSSListParser.h"

@interface SelectRSSListParser(){
    BOOL isPubdateTagFlag;
    BOOL isItemTagFlag;
    BOOL isTitleTagFlag;
    BOOL isLinkTagFlag;
    BOOL isDescriptionTagFlag;
    NSArray *resultRecord;
    NSString *pubDateBuffer;
    NSString *itemBuffer;
    NSString *titleBuffer;
    NSString *linkBuffer;
    NSString *descriptionBuffer;
}

@end


@implementation SelectRSSListParser
@synthesize result;
/**
 * イニシャライザ
 */
- (id)init{
    self.result = [NSMutableArray array];
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    // tag名の取得は、elementNameで
    // 属性値の取得は、[attributeDict objectForKey:@"hogehoge"]
    
   //NSLog(@"start:  %@",elementName);
    if ([elementName isEqualToString:@"item"]) {
        isItemTagFlag = YES;
        //textBuffer初期化
        itemBuffer =@"";
    } else if ([elementName isEqualToString:@"pubDate"]) {
       isPubdateTagFlag = YES;
        //textBuffer初期化
        pubDateBuffer =@"";
    } else if ([elementName isEqualToString:@"title"]) {
        isTitleTagFlag = YES;
        //textBuffer初期化
        titleBuffer =@"";
    } else if ([elementName isEqualToString:@"link"]){
        isLinkTagFlag = YES;
        //textBuffer初期化
        linkBuffer =@"";
    }else if ([elementName isEqualToString:@"description"]){
        isDescriptionTagFlag = YES;
        //textBuffer初期化
        descriptionBuffer =@"";
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(isPubdateTagFlag){
        pubDateBuffer =[pubDateBuffer stringByAppendingString:string];
    }
    if(isItemTagFlag) {
        itemBuffer =[itemBuffer stringByAppendingString:string];
    }
    if(isTitleTagFlag) {
        titleBuffer =[titleBuffer stringByAppendingString:string];
    }
    if(isLinkTagFlag) {
        linkBuffer =[linkBuffer stringByAppendingString:string];
    }
    if(isDescriptionTagFlag) {
        descriptionBuffer =[descriptionBuffer stringByAppendingString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    //NSLog(@"end:  %@",elementName);
    if ([elementName isEqualToString:@"title"]) {
        isTitleTagFlag = NO;
    }
    if ([elementName isEqualToString:@"link"]) {
        isLinkTagFlag = NO;
    }
    if ([elementName isEqualToString:@"description"]) {
        isDescriptionTagFlag = NO;

    }
    if ([elementName isEqualToString:@"pubDate"]) {
        isPubdateTagFlag = NO;
    }
    if ([elementName isEqualToString:@"item"]) {
        isItemTagFlag = NO;
        resultRecord =
        [NSArray arrayWithObjects:titleBuffer ,linkBuffer,descriptionBuffer,pubDateBuffer, nil];
        [result addObject:resultRecord];
    }
    if([elementName isEqualToString:@"channel"]) {
        
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"error: %@",parseError);
}


@end

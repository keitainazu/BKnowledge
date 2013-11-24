//
//  SelectCListParser.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/07.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "SelectCListParser.h"



@interface SelectCListParser(){
    BOOL isTitleTagFlag;
    BOOL isIdTagFlag;
    BOOL isRecordTagFlag;
    NSArray *resultRecord;
    NSString *txtTitleBuffer;
    NSString *txtIdBuffer;
}

@end

@implementation SelectCListParser
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
    if ([elementName isEqualToString:@"Headtitle"]) {
        NSLog(@"Headtitle");
        
        
    } else if ([elementName isEqualToString:@"record"]) {
        isRecordTagFlag = YES;
    } else if ([elementName isEqualToString:@"title"]) {
        isTitleTagFlag = YES;
        //textBuffer初期化
        txtTitleBuffer =@"";
    } else if ([elementName isEqualToString:@"id"]){
        isIdTagFlag = YES;
        //textBuffer初期化
        txtIdBuffer =@"";
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(isTitleTagFlag){
        txtTitleBuffer =[txtTitleBuffer stringByAppendingString:string];
    }
    if(isIdTagFlag) {
        txtIdBuffer =[txtIdBuffer stringByAppendingString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"title"]) {
        isTitleTagFlag = NO;
    }
    if ([elementName isEqualToString:@"id"]) {
        isIdTagFlag = NO;
    }
    if ([elementName isEqualToString:@"record"]) {
        resultRecord =[NSArray arrayWithObjects:txtTitleBuffer,txtIdBuffer, nil];
        [result addObject:resultRecord];
        isRecordTagFlag = NO;
    }
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"error: %@",parseError);
}
@end


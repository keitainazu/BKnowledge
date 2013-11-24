//
//  SelectKListParser.m
//  BKnowledge
//
//  Created by keita inazu on 2013/06/30.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "SelectKListParser.h"
@interface SelectKListParser(){
    BOOL isTitleTagFlag;
    BOOL isUrlTagFlag;
    BOOL isRecordTagFlag;
    NSArray *resultRecord;
    NSString *txtTitleBuffer;
    NSString *txtUrlBuffer;
}

@end

@implementation SelectKListParser
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
    } else if ([elementName isEqualToString:@"url"]){
        isUrlTagFlag = YES;
        //textBuffer初期化
        txtUrlBuffer =@"";
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

    if(isTitleTagFlag){
        txtTitleBuffer =[txtTitleBuffer stringByAppendingString:string];
    }
    if(isUrlTagFlag) {
        txtUrlBuffer =[txtUrlBuffer stringByAppendingString:string];
    }

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"title"]) {
        NSLog(@"moji::%@",txtTitleBuffer);
        isTitleTagFlag = NO;
    }
    if ([elementName isEqualToString:@"url"]) {
        isTitleTagFlag = NO;
    }
    if ([elementName isEqualToString:@"record"]) {
        resultRecord =[NSArray arrayWithObjects:txtTitleBuffer,txtUrlBuffer, nil];
        [result addObject:resultRecord];
        isRecordTagFlag = NO;
    }
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"error: %@",parseError);
}
@end

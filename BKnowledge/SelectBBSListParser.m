//
//  SelectBBSListParser.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/09.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "SelectBBSListParser.h"

@interface SelectBBSListParser(){
    BOOL isCommentTagFlag;
    BOOL isNoTagFlag;
    BOOL isRecordTagFlag;
    NSArray *resultRecord;
    NSString *txtCommentBuffer;
    NSString *txtNoBuffer;
}

@end

@implementation SelectBBSListParser
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
    } else if ([elementName isEqualToString:@"comment"]) {
        isCommentTagFlag = YES;
        //textBuffer初期化
        txtCommentBuffer =@"";
    } else if ([elementName isEqualToString:@"no"]){
        isNoTagFlag = YES;
        //textBuffer初期化
        txtNoBuffer =@"";
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(isCommentTagFlag){
        txtCommentBuffer =[txtCommentBuffer stringByAppendingString:string];
    }
    if(isNoTagFlag) {
        txtNoBuffer =[txtNoBuffer stringByAppendingString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"comment"]) {
        NSLog(@"moji::%@",txtCommentBuffer);
        isCommentTagFlag = NO;
    }
    if ([elementName isEqualToString:@"no"]) {
        isNoTagFlag = NO;
    }
    if ([elementName isEqualToString:@"record"]) {
        NSLog(@"ここまできている");
        resultRecord =[NSArray arrayWithObjects:txtCommentBuffer,txtNoBuffer, nil];
        [result addObject:resultRecord];
        isRecordTagFlag = NO;
    }
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"error: %@",parseError);
}
@end

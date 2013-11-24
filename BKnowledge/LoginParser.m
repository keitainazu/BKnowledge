//
//  LoginParser.m
//  BKnowledge
//
//  Created by keita inazu on 2013/06/30.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "LoginParser.h"

@interface LoginParser (){
    BOOL isContentTagFlag;
}
@end
@implementation LoginParser
@synthesize isLoginSuccess;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    // tag名の取得は、elementNameで
    // 属性値の取得は、[attributeDict objectForKey:@"hogehoge"]
    if ([elementName isEqualToString:@"Headtitle"]) {
        NSLog(@"Headtitle");
    } else if ([elementName isEqualToString:@"Content"]) {
        isContentTagFlag = YES;
    } else {
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if(isContentTagFlag){
        NSLog(@"content:%@",string);
        if([string isEqualToString:@"true"]){
            isLoginSuccess = YES;
        }else {
            isLoginSuccess = NO;
        }
        isContentTagFlag = NO;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
}

- (void)parser:(NSXMLParser *)parser
parseErrorOccurred:(NSError *)parseError {
    NSLog(@"error: %@",parseError);
}

@end

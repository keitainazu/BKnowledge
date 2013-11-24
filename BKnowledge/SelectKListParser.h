//
//  SelectKListParser.h
//  BKnowledge
//
//  Created by keita inazu on 2013/06/30.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectKListParser : NSXMLParser
<NSXMLParserDelegate>
@property (nonatomic, strong) NSMutableArray *result;
@end

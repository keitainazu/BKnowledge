//
//  SelectBBSListParser.h
//  BKnowledge
//
//  Created by keita inazu on 2013/07/09.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectBBSListParser : NSXMLParser
<NSXMLParserDelegate>
@property (nonatomic, strong) NSMutableArray *result;
@end

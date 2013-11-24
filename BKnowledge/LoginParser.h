//
//  LoginParser.h
//  BKnowledge
//
//  Created by keita inazu on 2013/06/30.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginParser : NSObject
<NSXMLParserDelegate>
@property (nonatomic,assign) BOOL isLoginSuccess;
@end

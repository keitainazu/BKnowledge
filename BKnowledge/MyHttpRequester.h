//
//  MyHttpRequester.h
//  BKnowledge
//
//  Created by keita inazu on 2013/06/13.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHttpRequester : NSObject
<NSXMLParserDelegate>
@property (nonatomic,assign) BOOL isLoginSuccess;

//アクション定義
-(void) loginRequest:(NSMutableArray *)param;
-(NSMutableArray *) selectKListRequest:(NSMutableArray *)param;
-(NSMutableArray *) selectCListRequest;
-(NSMutableArray *) selectRSSListRequest;
-(NSMutableArray *) selectBBSListRequest :(NSString *) bbs_id;
-(void) registBBS:(NSString *) comment id:(NSString *)bbs_id regist_member_id:(NSString *) regist_member_id;
-(void)  registComm:(NSString *) title comment:(NSString *)comment regist_member_id:(NSString *) regist_member_id;
-(void)  registKnowledge:(NSString *) category layer:(NSString *)layer title:(NSString *)title url:(NSString *) url regist_member_id:(NSString *) regist_member_id;
@end

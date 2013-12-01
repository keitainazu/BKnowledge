//
//  MyHttpRequester.m
//  BKnowledge
//
//  Created by keita inazu on 2013/06/13.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "MyHttpRequester.h"
#import "LoginParser.h"
#import "SelectKListParser.h"
#import "SelectCListParser.h"
#import "SelectBBSListParser.h"
#import "SelectRSSListParser.h"

@interface  MyHttpRequester (){
    NSData *receivedData;
}
@end

@implementation MyHttpRequester 

-(void) loginRequest:(NSMutableArray *)param {
    // 送信したいURLを作成する
    NSURL *url = [NSURL URLWithString:@"https://mods-fat.ssl-lolipop.jp/loginApi.php"];
    // Mutableなインスタンスを作成し、インスタンスの内容を変更できるようにする
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // MethodにPOSTを指定する。
    request.HTTPMethod = @"POST";
    
    NSString *id = [param objectAtIndex:0];
    NSString *password =[param objectAtIndex:1];
    NSString *body =[NSString stringWithFormat:@"id=%@&password=%@",id,password];   
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    receivedData = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:nil
                                                          error:nil];
    
    //NSString * responseString = [[[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding]autorelease];   
    NSXMLParser *p = [[NSXMLParser alloc] initWithData:receivedData];
    LoginParser *parser =[LoginParser alloc];
    [p setDelegate:parser];
    [p parse];
    self.isLoginSuccess =parser.isLoginSuccess;
}

-(NSMutableArray *) selectKListRequest:(NSMutableArray *)param {
    
    receivedData =[[NSData alloc]init];
    // 送信したいURLを作成する
    NSURL *url = [NSURL URLWithString:@"https://mods-fat.ssl-lolipop.jp/selectKListApi.php"];
    // Mutableなインスタンスを作成し、インスタンスの内容を変更できるようにする
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // MethodにPOSTを指定する。
    request.HTTPMethod = @"POST";
    
    NSString *category = [param objectAtIndex:0];    
    NSString *layer =[param objectAtIndex:1];
    NSString *body =[NSString stringWithFormat:@"category=%@&layer=%@",category,layer];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    receivedData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:nil
                                                             error:nil];
    //NSString *string = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    //NSLog(@"ここでエンコードしたよ%@",string);
    //receivedData = [string dataUsingEncoding:NSUTF8StringEncoding];
    SelectKListParser *parser = [[SelectKListParser alloc] initWithData:receivedData];
    parser = [parser init];
    [parser setDelegate:parser];
    [parser parse];
    return [parser result];
}
-(NSMutableArray *) selectCListRequest{
    
    receivedData =[[NSData alloc]init];
    // 送信したいURLを作成する
    NSURL *url = [NSURL URLWithString:@"https://mods-fat.ssl-lolipop.jp/selectCListApi.php"];
    // Mutableなインスタンスを作成し、インスタンスの内容を変更できるようにする
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // MethodにPOSTを指定する。
    request.HTTPMethod = @"POST";
    
    NSString *count = @"1";
    NSString *body =[NSString stringWithFormat:@"count=%@",count];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    receivedData = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    SelectCListParser *parser = [[SelectCListParser alloc] initWithData:receivedData];
    parser = [parser init];
    [parser setDelegate:parser];
    [parser parse];
    return [parser result];
}

-(NSMutableArray *) selectRSSListRequest{
    
    /*receivedData =[[NSData alloc]init];
    // 送信したいURLを作成する
    NSURL *url = [NSURL URLWithString:@"http://rss.rssad.jp/rss/itmatmarkit/rss.xml"];
    // Mutableなインスタンスを作成し、インスタンスの内容を変更できるようにする
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // MethodにPOSTを指定する。
    request.HTTPMethod = @"POST";
    
    NSString *count = @"1";
    NSString *body =[NSString stringWithFormat:@"count=%@",count];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    receivedData = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
     */
    NSURL *url = [NSURL URLWithString:@"http://rss.rssad.jp/rss/itmatmarkit/rss.xml"];
    SelectRSSListParser *parser = [[SelectRSSListParser alloc] initWithContentsOfURL:url];
    parser = [parser init];
    [parser setDelegate:parser];
    [parser parse];
    return [parser result];
}


-(NSMutableArray *) selectBBSListRequest :(NSString *) bbs_id{
    
    receivedData =[[NSData alloc]init];
    // 送信したいURLを作成する
    NSURL *url = [NSURL URLWithString:@"https://mods-fat.ssl-lolipop.jp/selectBBSListApi.php"];
    // Mutableなインスタンスを作成し、インスタンスの内容を変更できるようにする
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // MethodにPOSTを指定する。
    request.HTTPMethod = @"POST";
    
    NSString *body =[NSString stringWithFormat:@"id=%@",bbs_id];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    receivedData = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    SelectBBSListParser *parser = [[SelectBBSListParser alloc] initWithData:receivedData];
    parser = [parser init];
    [parser setDelegate:parser];
    [parser parse];
    return [parser result];
}

-(void)  registBBS:(NSString *) comment id:(NSString *)bbs_id regist_member_id:(NSString *) regist_member_id{
    
    // 送信したいURLを作成する
    NSURL *url = [NSURL URLWithString:@"https://mods-fat.ssl-lolipop.jp/insertBBSApi.php"];
    // Mutableなインスタンスを作成し、インスタンスの内容を変更できるようにする
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // MethodにPOSTを指定する。
    request.HTTPMethod = @"POST";
    
    NSString *body =
     [NSString stringWithFormat:@"id=%@&comment=%@&regist_member_id=%@",bbs_id,comment,regist_member_id];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
}

-(void)  registComm:(NSString *) title comment:(NSString *)comment regist_member_id:(NSString *) regist_member_id{
    
    // 送信したいURLを作成する
    NSURL *url = [NSURL URLWithString:@"https://mods-fat.ssl-lolipop.jp/insertCommApi.php"];
    // Mutableなインスタンスを作成し、インスタンスの内容を変更できるようにする
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // MethodにPOSTを指定する。
    request.HTTPMethod = @"POST";
    
    NSString *body =
    [NSString stringWithFormat:@"title=%@&comment=%@&regist_member_id=%@",title,comment,regist_member_id];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:nil];
}

-(void)  registKnowledge:(NSString *) category layer:(NSString *)layer title:(NSString *)title url:(NSString *) url regist_member_id:(NSString *) regist_member_id{
    
    // 送信したいURLを作成する
    NSURL *request_url = [NSURL URLWithString:@"https://mods-fat.ssl-lolipop.jp/insertKnowledgeApi.php"];
    // Mutableなインスタンスを作成し、インスタンスの内容を変更できるようにする
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:request_url];
    // MethodにPOSTを指定する。
    request.HTTPMethod = @"POST";
    
    NSString *body =
    [NSString stringWithFormat:@"category=%@&layer=%@&title=%@&url=%@&regist_member_id=%@",category,layer,title,url,regist_member_id];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:nil];
}




@end



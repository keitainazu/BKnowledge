//
//  PageKDetail.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/02.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "PageKDetail.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface PageKDetail () {
    AppDelegate* delegate;
}

@end

@implementation PageKDetail
@synthesize url;


- (void)viewDidLoad
{
    [super viewDidLoad];
    delegate = [[UIApplication sharedApplication] delegate];
    //リクエストの生成

   
    NSString *afterUrl = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   // NSLog(@"Detail:     %@",afterUrl);
    NSURL *nsUrl = [NSURL URLWithString:afterUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl];
    [_webView loadRequest:request];
    _webView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ページ読込開始直後に呼ばれるデリゲートメソッド
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 2.SVProgressHUDを表示する
    [SVProgressHUD show];
}

// ページ読込終了直後に呼ばれるデリゲートメソッド
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 3.SVProgressHUDを非表示にする
    [SVProgressHUD dismiss];
}

@end

//
//  PageKDetail.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/02.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "PageKDetail.h"
#import "AppDelegate.h"
#import "PageK1ListTableViewController.h"
#import "SVProgressHUD.h"

@interface PageKDetail () {
    AppDelegate* delegate;
}
@end

@implementation PageKDetail
@synthesize url;
//サーバとのコネクション情報を保持
NSURLConnection *connection = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    delegate = [[UIApplication sharedApplication] delegate];
    //リクエストの生成
    NSLog(@"HOgehogehoge:  %@",url);
    //NSString *decURl =[self urldecode : url];
    //NSLog(@"MOGERA : %@",decURl);
    //NSString *gUrl =@"http://www.okuramkt.com/dic/effect/conversion_rate2.html";
    NSString *afterUrl = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSURL *nsUrl = [NSURL URLWithString:encodedString];
    //NSLog(@"Detail:     %@",encodedString);
    //NSURL *nsUrl = [NSURL URLWithString:decURl];
    NSLog(@"Detail:     %@",afterUrl);
    NSURL *nsUrl = [NSURL URLWithString:afterUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl];
    [_kWebView loadRequest:request];
    _kWebView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ページ読込開始直後に呼ばれるデリゲートメソッド
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"konnnatokoronikita");
    // 2.SVProgressHUDを表示する
    [SVProgressHUD show];
}

// ページ読込終了直後に呼ばれるデリゲートメソッド
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     NSLog(@"kなんだかな");
    // 3.SVProgressHUDを非表示にする
    [SVProgressHUD dismiss];
}
- (NSString *)urlencode:(NSString *)plainString
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)plainString,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8);
}

- (NSString *)urldecode:(NSString *)escapedUrlString
{
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)escapedUrlString,
                                                                                                 CFSTR(""),
                                                                                                 kCFStringEncodingUTF8);
}
// delegateメソッド
// webViewが画面のloadに失敗したら呼ばれる
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"問題の読み込みに失敗しました", @"")
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK",nil];
    [alert show];
    NSLog(@"error: %@", error);
    return;
}
@end

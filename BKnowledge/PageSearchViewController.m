//
//  PageSearchViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/08/03.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "PageSearchViewController.h"
#import "AppDelegate.h"
#import "RegistKnowledgeViewController.h"
#import "SVProgressHUD.h"

//pageKSearch
@interface PageSearchViewController () {
    AppDelegate* delegate;
    NSString* getResultURL;

}
@end

@implementation PageSearchViewController

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
    // バーにプラスボタンを追加
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addKnowledge)];
    button.style =UIBarButtonItemStyleBordered;
    

    
    // バーにボタンを追加
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                               initWithTitle:@"Back"
                               style:UIBarButtonItemStyleBordered
                               target:self
                               action:@selector(goBack)];
    
    // ナビゲーションバーにボタンをセット
    self.navigationItem.rightBarButtonItems =@[button,backButton];
    
    
	// Do any additional setup after loading the view.
    delegate = [[UIApplication sharedApplication] delegate];
    //リクエストの生成
    // NSString *afterUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url =@"http://www.google.co.jp";
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
- (void) addKnowledge {
    
    getResultURL = [_webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    delegate.ksearchURL =getResultURL;
    
    [self backBeforePage];
    
}
- (void) backBeforePage {
    //戻る
    [delegate.navigationController popViewControllerAnimated:YES];
    //[delegate.navigationController pushViewController:regist animated:YES];
}
- (void) goBack {
    if(_webView.canGoBack) {
          [_webView goBack];  
    }

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

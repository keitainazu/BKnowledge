//
//  PageRSSContentsViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/21.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "PageRSSContentsViewController.h"
#import "AppDelegate.h"
#import "RegistCommViewController.h"
#import "SVProgressHUD.h"

@interface PageRSSContentsViewController () {
    AppDelegate* delegate;
}

@end

@implementation PageRSSContentsViewController

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
	// Do any additional setup after loading the view.
    
    delegate = [[UIApplication sharedApplication] delegate];
    delegate.navigationController.navigationBarHidden = NO;
    
    
    // バーにプラスボタンを追加
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTopic)];
    button.style =UIBarButtonItemStyleBordered;
    self.navigationItem.rightBarButtonItem =button;
    
    
    //NSLog(@"link: %@",[[delegate.resultRSSList objectAtIndex:delegate.rss_row] objectAtIndex:1]);
   // NSLog(@"description: %@",[[delegate.resultRSSList objectAtIndex:delegate.rss_row] objectAtIndex:2]);
    
    //リクエストの生成
    // NSString *afterUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [[delegate.resultRSSList objectAtIndex:delegate.rss_row] objectAtIndex:1];
    NSString *afterUrl = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    // NSLog(@"Detail:     %@",afterUrl);
    NSURL *nsUrl = [NSURL URLWithString:afterUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl];
    [_web_view loadRequest:request];
    _web_view.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) addTopic {
    RegistCommViewController *regist = [self.storyboard instantiateViewControllerWithIdentifier:@"pageRegistComm"];
    regist.default_title = [[delegate.resultRSSList objectAtIndex:delegate.rss_row] objectAtIndex:0];
    regist.default_comment =[[delegate.resultRSSList objectAtIndex:delegate.rss_row] objectAtIndex:2];
     NSLog(@"::%@",regist.default_title);
    [delegate.navigationController pushViewController:regist animated:YES];
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

//
//  Page2ViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/06/13.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "Page2ViewController.h"
#import "PageK1ViewController.h"
#import "PageC1ListTableViewController.h"
#import "AppDelegate.h"


@interface Page2ViewController () {
    AppDelegate* delegate;
    UIViewController* view;
}
@end

@implementation Page2ViewController

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
    // 生成
    // タイトルを設定
    delegate = [[UIApplication sharedApplication] delegate];
    self.title = @"Select View";
 
    // バーにボタンを追加
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithTitle:@"Exit"
                               style:UIBarButtonItemStyleBordered
                               target:self
                               action:@selector(exitFunction)];

    // ナビゲーションバーの右に「2ページ」ボタンをセット
    self.navigationItem.rightBarButtonItem = button;

    //ここではback ボタンは消す
    self.navigationItem.hidesBackButton =YES;
    
    
    UITapGestureRecognizer *cTap
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCommunicationAction)];
    [_communicationImage addGestureRecognizer:cTap];
    UITapGestureRecognizer *kTap
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapKnowledgeAction)];
    [_knowledgeImage addGestureRecognizer:kTap];
}
- (void) exitFunction {
    exit(0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tapCommunicationAction {
    //遷移先ViewControllerクラスのインスタンス生成
    PageC1ListTableViewController *pageKList = [self.storyboard instantiateViewControllerWithIdentifier:@"pageCList"];
    [delegate.navigationController pushViewController:pageKList animated:YES];
    
}

- (void) tapKnowledgeAction {
    
    //遷移先ViewControllerクラスのインスタンス生成
    PageK1ViewController *pageK1VC = [self.storyboard instantiateViewControllerWithIdentifier:@"pageK1"];
    view =pageK1VC;
    [delegate.navigationController pushViewController:pageK1VC animated:YES];
    //[self presentViewController: pageK1VC animated:YES completion: nil];    
}
/*
-(void) showNextView{
    //遷移先ViewControllerクラスのインスタンス生成
    [delegate.navigationController pushViewController:view animated:YES];
}
*/


@end

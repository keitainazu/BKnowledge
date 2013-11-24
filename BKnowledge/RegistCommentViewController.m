//
//  RegistCommentViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/10.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "RegistCommentViewController.h"
#import "AppDelegate.h"

@interface RegistCommentViewController () {
     AppDelegate* delegate;
}
@end

@implementation RegistCommentViewController

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
    //delegate.navigationController.navigationBarHidden = NO;
    NSLog(@"bbs_id:%@",delegate.bbs_id);
    self.title = @"Comment";

    // バーにボタンを追加
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithTitle:@"Add Commnet"
                               style:UIBarButtonItemStyleBordered
                               target:self
                               action:@selector(registBBS)];
    button.style =UIBarButtonItemStyleBordered;
    self.navigationItem.rightBarButtonItem =button;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) registBBS {
    
    MyHttpRequester *httprequester = [MyHttpRequester alloc];
    [httprequester registBBS :_comment_txt.text id:delegate.bbs_id regist_member_id:@"test"];
    //戻る
    [delegate.navigationController popViewControllerAnimated:YES];

}

@end

//
//  RegistCommViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/16.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "RegistCommViewController.h"
#import "MyHttpRequester.h"
#import "AppDelegate.h"

@interface RegistCommViewController (){
    AppDelegate* delegate;
    BOOL *needScroll;
}
@end

@implementation RegistCommViewController
@synthesize default_title;
@synthesize default_comment;

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
    _title_txt.delegate =self;
    self.title = @"Add Article";
    
    // バーにボタンを追加
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithTitle:@"Add Airticle"
                               style:UIBarButtonItemStyleBordered
                               target:self
                               action:@selector(registComm)];
    button.style =UIBarButtonItemStyleBordered;
    self.navigationItem.rightBarButtonItem =button;
    
    //default値があれば設定する。
    _title_txt.text = default_title;
    _comment_txt.text =default_comment;
    
    [self registerForKeyboardNotifications];
    needScroll = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) registComm {
    
    NSLog(@"コメント%@",_comment_txt.text);
    MyHttpRequester *httprequester = [MyHttpRequester alloc];
    [httprequester registComm :_title_txt.text comment:_comment_txt.text regist_member_id:@"test"];
    //戻る
    [delegate.navigationController popViewControllerAnimated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)touch_title:(id)sender {
    needScroll = NO;
}

- (IBAction)edit_end_title:(id)sender {
    needScroll  = YES;
}

- (IBAction)down_button:(id)sender {
    [_comment_txt endEditing:YES];
    [_base_scroll setContentOffset:CGPointZero animated:YES];
}
//以下キーボードに隠れないようにする為
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if(needScroll){
        CGPoint scrollPoint = CGPointMake(0.0,100.0);
        [_base_scroll setContentOffset:scrollPoint animated:YES];
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [_base_scroll setContentOffset:CGPointZero animated:YES];
}

@end

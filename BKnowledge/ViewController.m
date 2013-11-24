//
//  ViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/06/09.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MyHttpRequester.h"
#import "Page2ViewController.h"
#import "Navi.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSString *login_id;
    NSString *password;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _user_id_text.delegate = self;
    _pass_text.delegate = self;

    [self registerForKeyboardNotifications];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login_button:(id)sender {
    login_id = _user_id_text.text;
    password = _pass_text.text;
    if([login_id isEqualToString:@""] || [password isEqualToString:@""]){
       [self failAlert];
        return;
    }

    NSMutableArray *param =[NSMutableArray arrayWithObjects:login_id, password,nil];
    MyHttpRequester *httprequester = [self loginAccess:param];
    if(httprequester.isLoginSuccess == YES){
        //遷移先ViewControllerクラスのインスタンス生成
        Page2ViewController *pageVC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"page2"];
        Navi *navi = [self.storyboard instantiateViewControllerWithIdentifier:@"navi"];
        AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        //ナビゲーションコントローラにベースとなるコントローラをセット
        delegate.navigationController = [[UINavigationController alloc] initWithRootViewController:navi];
        // ナビゲーションコントローラのビューをウィンドウに貼付ける
        [delegate.window addSubview:delegate.navigationController.view];
        [delegate.window makeKeyAndVisible];
        
        [delegate.navigationController pushViewController:pageVC2 animated:YES];
        delegate.navigationController.navigationBarHidden = YES;
       //[self presentViewController: pageVC2 animated:YES completion: nil];
    }else {
        [self failAlert];
    }
}


-(void) failAlert {
    UIAlertView *alert
    =[[UIAlertView alloc]
      initWithTitle:@"ログインできません"
      message:@"再度 ID,PASSWORDを入れてください"
      delegate:self
      cancelButtonTitle:nil
      otherButtonTitles:@"閉じる", nil];
    [alert show];
}
/**
*
*/
-(MyHttpRequester *) loginAccess:(NSMutableArray *)param{
    MyHttpRequester *httprequester = [MyHttpRequester alloc];
    [httprequester loginRequest : param];
    return httprequester;
}

// return keyを有効にする為の処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
    CGPoint scrollPoint = CGPointMake(0.0,100.0);
    [_base_scroll setContentOffset:scrollPoint animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [_base_scroll setContentOffset:CGPointZero animated:YES];
}
@end

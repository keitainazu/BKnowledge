//
//  RegistKnowledgeViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/16.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "RegistKnowledgeViewController.h"
#import "MyHttpRequester.h"
#import "AppDelegate.h"
#import <sqlite3.h>
#import "PageSearchViewController.h"

@interface RegistKnowledgeViewController () {
    AppDelegate* delegate;
    NSArray* pickerArray;
    NSArray* categoryArray;
    NSArray* layerArray;
    //初期化
    NSString* category;
    NSString* layer;
}

@end

@implementation RegistKnowledgeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    delegate = [[UIApplication sharedApplication] delegate];
    delegate.navigationController.navigationBarHidden = NO;
    self.title = @"RegistKnowledge";
	// Do any additional setup after loading the view.
    _url_txt.delegate = self;
    _category_picker.delegate =self;
    self.title = @"Add Knowledge";
    
    // バーにボタンを追加
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithTitle:@"Add Airticle"
                               style:UIBarButtonItemStyleBordered
                               target:self
                               action:@selector(registKnowledge)];
    button.style =UIBarButtonItemStyleBordered;
    self.navigationItem.rightBarButtonItem =button;
    
    
    //Picker初期か
    categoryArray = [NSArray arrayWithObjects:@"Basic",@"Program",@"Infra",nil];
    layerArray    = [NSArray arrayWithObjects:@"Summary",@"Middle",@"Detail",nil];
    pickerArray =[NSArray arrayWithObjects:categoryArray,layerArray,nil];
    [self registerForKeyboardNotifications];
    //初期化
    category =@"1";
    layer =@"1";
}
// 最初に描画されるときのメソッド
-(void)viewDidAppear:(BOOL)animated {
    
    _url_txt.text = delegate.ksearchURL;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void) registKnowledge {

    MyHttpRequester *httprequester = [MyHttpRequester alloc];
    NSString *before = _url_txt.text;
    NSString *after_url = [before stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httprequester registKnowledge:category layer:layer title:_title_txt.text url:after_url  regist_member_id:@"test"];
    
    //初期化
    delegate.ksearchURL =@"";
    _url_txt.text =@"";
    //戻る
    [delegate.navigationController popViewControllerAnimated:YES];
}

//UIPickerViewDataSource method
//コンポーネント数
-(NSInteger ) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    //compornent number
    return 2;
}
//要素数
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    //row number
    return 3;
}

//UIPickerView Delegate　method
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerArray[component][row];
    //return @"title";
}
//tocuch the picker delegate method
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component == 0){
        category = [NSString stringWithFormat:@"%d",row+1];
    }else {
        layer = [NSString stringWithFormat:@"%d",row+1];
    }
   // NSLog(@"category:   %@",category);
    //NSLog(@"layer:   %@",layer);
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
    CGPoint scrollPoint = CGPointMake(0.0,220.0);
    [_base_scroll setContentOffset:scrollPoint animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [_base_scroll setContentOffset:CGPointZero animated:YES];
}

- (IBAction)Search_button:(id)sender {
    PageSearchViewController *search =[self.storyboard instantiateViewControllerWithIdentifier:@"pageKSearch"];
    [delegate.navigationController pushViewController:search animated:YES];
}




@end

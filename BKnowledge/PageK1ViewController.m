//
//  PageK1ViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/06/29.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "AppDelegate.h"
#import "PageK1ViewController.h"
#import "MyHttpRequester.h"
#import "Page2ViewController.h"
#import "RegistKnowledgeViewController.h"

#define  CATEGORY_BASE  @"1";
#define  CATEGORY_PROGRAM  @"2";
#define  CATEGORY_INFRA  @"3";
#define  LAYER_SUMMARY  @"1";
#define  LAYER_MIDDLE  @"2";
#define  LAYER_DETAIL  @"3";

@interface PageK1ViewController () {
    BOOL firstTime;
    AppDelegate* delegate;
    NSString *selectCategory;
    NSString *selectLayer;
    UIViewController* view;
}

    
@end

@implementation PageK1ViewController 

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _baseImage.image =[UIImage imageNamed:@"base.png"];
        _programImage.image =[UIImage imageNamed:@"program.png"];
        _infraImage.image =[UIImage imageNamed:@"infra.png"];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    delegate = [[UIApplication sharedApplication] delegate];
    delegate.navigationController.navigationBarHidden = NO;
    self.title = @"Knowledge";
    firstTime = YES;
    NSLog(@"imakokonikitemasu");
    UITapGestureRecognizer *bTap
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBaseAction)];
    [_baseImage addGestureRecognizer:bTap];
    UITapGestureRecognizer *pTap
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProgramAction)];
    [_programImage addGestureRecognizer:pTap];
    UITapGestureRecognizer *iTap
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInfraAction)];
    [_infraImage addGestureRecognizer:iTap];
    UITapGestureRecognizer *homeTap
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHomeAction)];
    [_homeButtonImage addGestureRecognizer:homeTap];
    
    
    // バーにプラスボタンを追加
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addKnowledge)];
    button.style =UIBarButtonItemStyleBordered;
    self.navigationItem.rightBarButtonItem =button;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) tapBaseAction {
    [self tapCommonAction];
    if(firstTime){
        selectCategory = CATEGORY_BASE;
    }else {
        selectLayer = LAYER_SUMMARY;
        [self selectKList];
        [self nextPage];
    }
    
}
- (void) tapProgramAction {
    [self tapCommonAction];
    if(firstTime){
        selectCategory = CATEGORY_PROGRAM;
    }else {
        selectLayer = LAYER_MIDDLE;
        [self selectKList];
        [self nextPage];
    }
}
- (void) tapInfraAction {
    [self tapCommonAction];
    if(firstTime){
        selectCategory = CATEGORY_INFRA;
    }else {
        selectLayer = LAYER_DETAIL;
        [self selectKList];
        [self nextPage];
    }
}
- (void) tapHomeAction {
    Page2ViewController *paeVC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"page2"];
     [self presentViewController: paeVC2 animated:YES completion: nil];

}


-(void) tapCommonAction {
    if(firstTime) {
        _baseImage.image =[UIImage imageNamed:@"circle200.png"];
        _programImage.image =[UIImage imageNamed:@"circle200.png"];
        _infraImage.image =[UIImage imageNamed:@"circle200.png"];
 
       /* _baseImage.center = CGPointMake(160,100);
        _programImage.center = CGPointMake(80,250);
        _infraImage.center = CGPointMake(250,250);*/
    
   /* [UIView setAnimationDelegate:self];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
                                options: UIViewAnimationCurveEaseOut
    */
    
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                             _baseImage.frame = CGRectMake(50,60,200,100);
                             _programImage.frame = CGRectMake(50,180,200,100);
                             _infraImage.frame = CGRectMake(50,300,200,100);
                         }
                         completion: ^(BOOL finished){
                                 [self changeImage];
                          }];

        [UIView commitAnimations];
    }
}
-(void) changeImage{
    _baseImage.frame = CGRectMake(50,5,200,200);
    _programImage.frame = CGRectMake(50,110,200,200);
    _infraImage.frame = CGRectMake(50,230,200,200);
    _baseImage.image =[UIImage imageNamed:@"summary.png"];
    _programImage.image =[UIImage imageNamed:@"Middle.png"];
    _infraImage.image =[UIImage imageNamed:@"Detail.png"];
    firstTime =NO;
}

-(void) selectKList{

    //ここでデータを取得して詰め替えてる
    NSMutableArray *param =[[NSMutableArray alloc] initWithObjects:selectCategory,selectLayer, nil];
    MyHttpRequester *httprequester = [MyHttpRequester alloc];
    NSMutableArray *result = [httprequester selectKListRequest:param];
    // グローバル変数に保存
    delegate.resultKList = result;
}

-(void) nextPage{
    //遷移先ViewControllerクラスのインスタンス生成
    PageK1ViewController *pageKList = [self.storyboard instantiateViewControllerWithIdentifier:@"pageKList"];
    [delegate.navigationController pushViewController:pageKList animated:YES];
    //[self presentViewController: pageKList animated:YES completion: nil];
}


// 最初に描画されるときのメソッド
-(void)viewDidAppear:(BOOL)animated {

      firstTime = YES;
    // Custom initialization
     _baseImage.image =[UIImage imageNamed:@"base.png"];
    _programImage.image =[UIImage imageNamed:@"program.png"];
    _infraImage.image =[UIImage imageNamed:@"infra.png"];
}
- (void) addKnowledge {
    RegistKnowledgeViewController *regist = [self.storyboard instantiateViewControllerWithIdentifier:@"pageRegistKnowledge"];
    [delegate.navigationController pushViewController:regist animated:YES];
}

@end

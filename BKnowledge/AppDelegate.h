//
//  AppDelegate.h
//  BKnowledge
//
//  Created by keita inazu on 2013/06/09.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Navi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    //UIWindow *window;
    //UINavigationController *navigationController;
    //Page2ViewController *viewController;
}
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) Navi *viewController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *resultKList;
@property (strong, nonatomic) NSMutableArray *resultCList;
@property (strong, nonatomic) NSMutableArray *resultBBSList;
@property (strong, nonatomic) NSString *bbs_id;
@property (strong, nonatomic) NSMutableArray *resultRSSList;
@property (strong, nonatomic) NSString *rss_id;
@property (strong, nonatomic)NSString *ksearchURL;
@property                     int rss_row;
@end

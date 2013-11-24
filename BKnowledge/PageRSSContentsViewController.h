//
//  PageRSSContentsViewController.h
//  BKnowledge
//
//  Created by keita inazu on 2013/07/21.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageRSSContentsViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *web_view;

@end

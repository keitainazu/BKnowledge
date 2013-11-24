//
//  PageSearchViewController.h
//  BKnowledge
//
//  Created by keita inazu on 2013/08/03.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageSearchViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

//
//  PageKDetail.h
//  BKnowledge
//
//  Created by keita inazu on 2013/07/02.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageKDetail : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSString *url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

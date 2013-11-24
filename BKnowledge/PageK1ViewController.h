//
//  PageK1ViewController.h
//  BKnowledge
//
//  Created by keita inazu on 2013/06/29.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHttpRequester.h"
#import "PageK1ListTableViewController.h"

@interface PageK1ViewController : UIViewController {
    PageK1ListTableViewController *klist;
}
@property (weak, nonatomic) IBOutlet UIImageView *baseImage;

@property (weak, nonatomic) IBOutlet UIImageView *programImage;
@property (weak, nonatomic) IBOutlet UIImageView *infraImage;
@property (weak, nonatomic) IBOutlet UIImageView *homeButtonImage;

-(void) selectKList;
@end

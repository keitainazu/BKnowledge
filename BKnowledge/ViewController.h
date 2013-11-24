//
//  ViewController.h
//  BKnowledge
//
//  Created by keita inazu on 2013/06/09.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page2ViewController.h"

@interface ViewController : UIViewController
<UITextFieldDelegate>
{

    Page2ViewController *page2;
}
@property (weak, nonatomic) IBOutlet UIScrollView *base_scroll;
@property (weak, nonatomic) IBOutlet UITextField *user_id_text;
@property (weak, nonatomic) IBOutlet UITextField *pass_text;
- (IBAction)login_button:(id)sender;
@end

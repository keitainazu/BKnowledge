//
//  RegistCommViewController.h
//  BKnowledge
//
//  Created by keita inazu on 2013/07/16.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistCommViewController : UIViewController
<UITextFieldDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *base_scroll;
@property (weak, nonatomic) IBOutlet UITextField *title_txt;
@property (weak, nonatomic) IBOutlet UITextView *comment_txt;

@property (weak, nonatomic) NSString *default_title;
@property (weak, nonatomic) NSString *default_comment;
- (IBAction)touch_title:(id)sender;
- (IBAction)edit_end_title:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)down_button:(id)sender;
@end

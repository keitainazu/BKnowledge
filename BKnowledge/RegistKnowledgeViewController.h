//
//  RegistKnowledgeViewController.h
//  BKnowledge
//
//  Created by keita inazu on 2013/07/16.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistKnowledgeViewController : UIViewController
<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *base_scroll;
@property (weak, nonatomic) IBOutlet UITextField *url_txt;
@property (weak, nonatomic) IBOutlet UIPickerView *category_picker;
@property (weak, nonatomic) IBOutlet UITextField *title_txt;
- (IBAction)Search_button:(id)sender;
@end

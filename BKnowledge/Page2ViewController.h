//
//  Page2ViewController.h
//  BKnowledge
//
//  Created by keita inazu on 2013/06/13.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageK1ViewController.h"

@interface Page2ViewController : UIViewController {
    PageK1ViewController *k1;
}
@property (weak, nonatomic) IBOutlet UIImageView *knowledgeImage;
@property (weak, nonatomic) IBOutlet UIImageView *communicationImage;
- (void) tapCommunicationAction;
- (void) tapKnowledgeAction ;
@end

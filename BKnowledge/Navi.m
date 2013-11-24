//
//  Navi.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/06.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "Navi.h"

@interface Navi ()

@end

@implementation Navi

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"いまここで　navinaviがでる");
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

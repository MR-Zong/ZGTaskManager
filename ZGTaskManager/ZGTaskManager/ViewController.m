//
//  ViewController.m
//  ZGTaskManager
//
//  Created by Zong on 15/12/17.
//  Copyright © 2015年 Zong. All rights reserved.
//

#import "ViewController.h"
#import "ZGTaskManager.h"
#import "ZGTimerView.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZGTimerView *timerView = [[ZGTimerView alloc] init];
    timerView.frame = self.view.bounds;
    timerView.backgroundColor  = [UIColor yellowColor];
    [self.view addSubview:timerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

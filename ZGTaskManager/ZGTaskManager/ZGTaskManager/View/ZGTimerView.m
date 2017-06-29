//
//  ZGTimerView.m
//  TestPro
//
//  Created by Zong on 15/12/16.
//  Copyright © 2015年 Zong. All rights reserved.
//

#import "ZGTimerView.h"
#import "ZGTaskManager.h"
#import "ZGTimeIntevel.h"

@interface ZGTimerView ()

@property (nonatomic,weak) UILabel *timeLabel1;

@property (nonatomic,weak) UILabel *timeLabel2;

@property (nonatomic,weak) UILabel *timeLabel3;

@property (nonatomic,weak) UILabel *timeLabel4;

@property (nonatomic,strong) NSArray *timeIntevel;

@property (nonatomic,strong) ZGTaskManager *taskManager;

@end

@implementation ZGTimerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    
    return self;
}


- (void)initView
{
    self.taskManager = [ZGTaskManager shareTaskManager];
    
    [self initTimeIntevel];
    
    UILabel *timeLabel1 = [[UILabel alloc] init];
    self.timeLabel1 = timeLabel1;
    self.timeLabel1.backgroundColor = [UIColor greenColor];
    self.timeLabel1.frame = CGRectMake(80, 100, 60, 30);
    __weak ZGTimerView *weakSelf = self;
    self.timeLabel1.text = [self timeStrWithNumber:((ZGTimeIntevel *)self.timeIntevel[0]).timeIntevel];
    [self.taskManager addTaskWithAfter:0 timeIntervel:1 block:^BOOL{
       ZGTimeIntevel *totalTime = weakSelf.timeIntevel[0];
        totalTime.timeIntevel--;
        weakSelf.timeLabel1.text = [weakSelf timeStrWithNumber:totalTime.timeIntevel];
        if (totalTime.timeIntevel <= 0) {
            return NO;
        }else {
            return YES;
        }
        
    }];
    
    
    
    
    [self addSubview:timeLabel1];
    
    UILabel *timeLabel2 = [[UILabel alloc] init];
    self.timeLabel2 = timeLabel2;
    self.timeLabel2.backgroundColor = [UIColor whiteColor];
    self.timeLabel2.text = [self timeStrWithNumber:((ZGTimeIntevel *)self.timeIntevel[0]).timeIntevel];
    [self.taskManager addTaskWithAfter:0 timeIntervel:1 block:^BOOL{
        ZGTimeIntevel *totalTime = weakSelf.timeIntevel[1];
        totalTime.timeIntevel--;
        weakSelf.timeLabel2.text = [weakSelf timeStrWithNumber:totalTime.timeIntevel];
        if (totalTime.timeIntevel <= 0) {
            return NO;
        }else {
            return YES;
        }
        
    }];
    self.timeLabel2.frame = CGRectMake(160, 100, 60, 30);
    [self addSubview:timeLabel2];
    
    
    
    UILabel *timeLabel3 = [[UILabel alloc] init];
    self.timeLabel3 = timeLabel3;
    self.timeLabel3.backgroundColor = [UIColor whiteColor];
    self.timeLabel3.frame = CGRectMake(80, 150, 60, 30);
    self.timeLabel3.text = [self timeStrWithNumber:((ZGTimeIntevel *)self.timeIntevel[0]).timeIntevel];
    [self.taskManager addTaskWithAfter:0 timeIntervel:1 block:^BOOL{
        ZGTimeIntevel *totalTime = weakSelf.timeIntevel[2];
        totalTime.timeIntevel--;
        weakSelf.timeLabel3.text = [weakSelf timeStrWithNumber:totalTime.timeIntevel];
        if (totalTime.timeIntevel <= 0) {
            return NO;
        }else {
            return YES;
        }
        
    }];
    [self addSubview:timeLabel3];
    
    
    
    UILabel *timeLabel4 = [[UILabel alloc] init];
    self.timeLabel4 = timeLabel4;
    self.timeLabel4.backgroundColor = [UIColor greenColor];
    self.timeLabel4.frame = CGRectMake(160, 150, 60, 30);
    self.timeLabel4.text = [self timeStrWithNumber:((ZGTimeIntevel *)self.timeIntevel[0]).timeIntevel];
    [self.taskManager addTaskWithAfter:0 timeIntervel:1 block:^BOOL{
        ZGTimeIntevel *totalTime = weakSelf.timeIntevel[3];
        totalTime.timeIntevel--;
        weakSelf.timeLabel4.text = [weakSelf timeStrWithNumber:totalTime.timeIntevel];
        if (totalTime.timeIntevel <= 0) {
            return NO;
        }else {
            return YES;
        }
        
    }];
    
    [self addSubview:timeLabel4];
    
    
}


- (NSString *)timeStrWithNumber:(NSUInteger)timeIntevel
{
    return [NSString stringWithFormat:@"%zd",timeIntevel];
}

- (ZGTimeIntevel *)timeIntevelWithDict:(NSDictionary *)dict
{
    NSInteger timeIntevelInt = [dict[@"endTime"] intValue] - [dict[@"curTiem"] intValue];
    return [ZGTimeIntevel timerIntevelWithNumber:timeIntevelInt];
}

- (void)initTimeIntevel
{
    NSDictionary *dict1 = @{
                            @"curTime":@"10",
                            @"endTime":@"65"
                            };
    NSDictionary *dict2 = @{
                            @"curTime":@"10",
                            @"endTime":@"87"
                            };
    NSDictionary *dict3 = @{
                            @"curTime":@"10",
                            @"endTime":@"108"
                            };
    NSDictionary *dict4 = @{
                            @"curTime":@"10",
                            @"endTime":@"20"
                            };
    NSArray *buyTimerAry = @[dict1,dict2,dict3,dict4];
    
    NSMutableArray *mAry = [NSMutableArray array];
    
    for (NSDictionary *dict in buyTimerAry) {
        
        [mAry addObject:[self timeIntevelWithDict:dict]];
    }
    
    self.timeIntevel = [mAry copy];
}



@end

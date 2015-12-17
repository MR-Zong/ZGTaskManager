//
//  ZGTaskManager.m
//  TestPro
//
//  Created by Zong on 15/12/16.
//  Copyright © 2015年 Zong. All rights reserved.
//

#import "ZGTaskManager.h"


static ZGTaskManager *taskManager_ ;

@interface ZGTaskManager ()

@property (nonatomic,strong) NSMutableArray *tasks;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ZGTaskManager

+ (instancetype)shareTaskManager
{
    if (!taskManager_) {
        taskManager_ = [[self alloc] init];
    }
    return taskManager_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{

    static dispatch_once_t onceToken;
    if (!taskManager_) {
        dispatch_once(&onceToken, ^{
            taskManager_ = [super allocWithZone:zone];
        });
    }
    
    return taskManager_;
}

- (void)addTaskWithBlock:(Task)task
{
    if (task == nil) return;
    
    [self.tasks addObject:task];
    
    [self timer];
}


- (void)onTimer
{
    NSLog(@"tasks.count %zd",self.tasks.count);
    if (self.tasks.count > 0) {
        
        for (int i =0 ; i<self.tasks.count; i++) {
            
            Task task = self.tasks[i];
            if (task) {
                if (!task()) {
                    
                    [self.tasks removeObject:task];
                }
            }
        }
        
        
    }else {
        [self.timer invalidate];
        self.timer = nil;
        NSLog(@"timer invalidate");
    }
}

#pragma mark -lazyLoad
- (NSMutableArray *)tasks
{
    if (!_tasks){
        _tasks = [NSMutableArray array];
    }
    return _tasks;
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end

//
//  ZGTaskManager.m
//  TestPro
//
//  Created by Zong on 15/12/16.
//  Copyright © 2015年 Zong. All rights reserved.
//

#import "ZGTaskManager.h"


static ZGTaskManager *_taskManager_ ;


@interface ZGTaskModel : NSObject

@property (nonatomic, copy) ZGTaskBlock taskBlock;
@property (nonatomic, assign) NSUInteger beginTime;
@property (nonatomic, assign) NSUInteger timeIntervel;
@property (nonatomic, assign) NSUInteger afterSeconds;

+ (instancetype)taskModelWithAfter:(NSUInteger)afterSeconds timeIntervel:(NSUInteger)timeIntervel taskBlock:(ZGTaskBlock)taskBlock;

@end

@implementation ZGTaskModel

+ (instancetype)taskModelWithAfter:(NSUInteger)afterSeconds timeIntervel:(NSUInteger)timeIntervel taskBlock:(ZGTaskBlock)taskBlock
{
    ZGTaskModel *taskModel = [[ZGTaskModel alloc] init];
    taskModel.timeIntervel = timeIntervel;
    taskModel.taskBlock = taskBlock;
    taskModel.afterSeconds = afterSeconds;
    return taskModel;
}

@end

#pragma mark -

@interface ZGTaskManager ()

@property (nonatomic,strong) NSMutableArray *tasks;

@property (nonatomic,strong) NSMutableArray *invalidateTasks;

@property (nonatomic,strong) NSTimer *timer;


@end

@implementation ZGTaskManager

+ (instancetype)shareTaskManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _taskManager_ = [[ZGTaskManager alloc] init];
    });
    
    return _taskManager_;
}

//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//
//    static dispatch_once_t onceToken;
//    if (!taskManager_) {
//        dispatch_once(&onceToken, ^{
//            taskManager_ = [super allocWithZone:zone];
//        });
//    }
//
//    return taskManager_;
//}


- (void)terminate
{
    [self.timer invalidate];
    self.timer = nil;
    
    self.tasks = nil;
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}


/**
 * after 延迟调用时间  timeIntervel 时间间隔  block 任务
 */
- (void)addTaskWithAfter:(NSUInteger)afterSeconds timeIntervel:(NSUInteger)timeIntervel block:(ZGTaskBlock)taskBlock
{
    if (taskBlock == nil) return;
    if (timeIntervel == 0) return;
    
    [self.tasks addObject:[ZGTaskModel taskModelWithAfter:afterSeconds timeIntervel:timeIntervel taskBlock:taskBlock]];
    
    [self timer];
}


- (void)onTimer
{
    self.totalTime++;
    
    if (self.tasks.count > 0) {
        
        for (int i =0 ; i<self.tasks.count; i++) {
            
            ZGTaskModel *taskModel = self.tasks[i];
            
            if (taskModel.afterSeconds > 0) {
                taskModel.afterSeconds--;
                if (taskModel.afterSeconds <= 0) { // 减到0立马调用taskBlock
                    taskModel.beginTime = self.totalTime;
                    if (taskModel.taskBlock) {
                        if (!taskModel.taskBlock()) {
                            
                            [self.invalidateTasks addObject:taskModel];
                        }
                    }
                }

            }else {
                
                // 设置beginTime 并立即调用taskBlock
                if (taskModel.beginTime == 0) {
                    taskModel.beginTime = self.totalTime;
                }
                NSUInteger timeOffset = self.totalTime - taskModel.beginTime;
                if ( timeOffset == taskModel.timeIntervel) {
                    taskModel.beginTime = self.totalTime;
                    if (taskModel.taskBlock) {
                        if (!taskModel.taskBlock()) {
                            [self.invalidateTasks addObject:taskModel];
                        }
                    }
                }
                
            }// end if (taskModel.afterSeconds > 0)
            
            
        }
        
        
        
        // for 外面才能remove数组里的元素
        for (int i =0 ; i<self.invalidateTasks.count; i++) {
            ZGTaskModel *invalidateTaskModel = self.invalidateTasks[i];
            [self.tasks removeObject:invalidateTaskModel];
        }
        
        [self.invalidateTasks removeAllObjects];
        
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

- (NSMutableArray *)invalidateTasks
{
    if (!_invalidateTasks) {
        _invalidateTasks = [NSMutableArray array];
    }
    return _invalidateTasks;
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

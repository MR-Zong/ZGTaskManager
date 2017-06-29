//
//  ZGTaskManager.h
//  TestPro
//
//  Created by Zong on 15/12/16.
//  Copyright © 2015年 Zong. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef BOOL (^ZGTaskBlock)(void);

@interface ZGTaskManager : NSObject

@property (nonatomic, assign) NSUInteger totalTime;

+ (instancetype)shareTaskManager;

/**
 * after 延迟调用时间  timeIntervel 时间间隔  block 任务
 */
- (void)addTaskWithAfter:(NSUInteger)afterSeconds timeIntervel:(NSUInteger)timeIntervel block:(ZGTaskBlock)taskBlock;

- (void)terminate;

@end

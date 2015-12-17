//
//  ZGTaskManager.h
//  TestPro
//
//  Created by Zong on 15/12/16.
//  Copyright © 2015年 Zong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^Task)(void);

@interface ZGTaskManager : NSObject


+ (instancetype)shareTaskManager;

- (void)addTaskWithBlock:(Task)task;

@end

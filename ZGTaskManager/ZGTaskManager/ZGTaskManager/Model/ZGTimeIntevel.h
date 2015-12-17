//
//  ZGTimeIntevel.h
//  TestPro
//
//  Created by Zong on 15/12/16.
//  Copyright © 2015年 Zong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGTimeIntevel : NSObject

@property (nonatomic,assign) NSInteger intevel;

+ (instancetype)timerIntevelWithNumber:(NSInteger)timeIntevel;

@end

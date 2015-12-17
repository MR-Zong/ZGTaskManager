//
//  ZGTimeIntevel.m
//  TestPro
//
//  Created by Zong on 15/12/16.
//  Copyright © 2015年 Zong. All rights reserved.
//

#import "ZGTimeIntevel.h"

@implementation ZGTimeIntevel


+ (instancetype)timerIntevelWithNumber:(NSInteger)timeIntevel
{
    ZGTimeIntevel *tmpTimeIntevel = [[ZGTimeIntevel alloc] init];
    tmpTimeIntevel.intevel = timeIntevel;
    return tmpTimeIntevel;
}


@end

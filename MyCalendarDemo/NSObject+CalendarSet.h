//
//  NSObject+CalendarSet.h
//  CalendarDemo
//
//  Created by 马浩哲 on 16/5/30.
//  Copyright © 2016年 MHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CalendarSet)

- (NSInteger)currentYear:(NSDate *)date;//获取当前的年份
- (NSInteger)currentMonth:(NSDate *)date;//获得当前的月份
- (NSInteger)currentDay:(NSDate *)date;//获取当前是哪一天
- (NSInteger)currentMonthOfDay:(NSDate *)date;//获取本月有多少天
- (NSInteger)preInMonth:(NSDate *)date;//获取上个月月份
- (NSInteger)nextMonth:(NSDate *)date;//获取下个月月份
- (NSInteger)preInMonthDay:(NSDate *)date;//获取上个月有多少天
- (NSInteger)currentFirstDay:(NSDate *)date;//获取当前月份第一天在星期几
- (NSMutableArray *)currentMonthArray:(NSDate *)date;//获得这个月排布数组

-(void)changeCurrentMonth:(NSDate *)date andIndex:(int)index resultData:(void(^)(NSDate *nowDate,NSString *showMonth))block;//获得上个月或者下个月的对应的nsdate和字符串

@end

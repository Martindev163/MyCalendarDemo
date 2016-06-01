//
//  NSObject+CalendarSet.m
//  CalendarDemo
//
//  Created by 马浩哲 on 16/5/30.
//  Copyright © 2016年 MHZ. All rights reserved.
//

#import "NSObject+CalendarSet.h"

@implementation NSObject (CalendarSet)
//获取当前年份
- (NSInteger)currentYear:(NSDate *)date
{
    NSDateComponents *componentsYear = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [componentsYear year];
}
//获取当前月份
- (NSInteger)currentMonth:(NSDate *)date
{
    NSDateComponents *componentsMonth = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [componentsMonth month];
}
//当前是哪一天
- (NSInteger)currentDay:(NSDate *)date
{
    NSDateComponents *componentsDay = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [componentsDay day];
}
//本月有几天
- (NSInteger)currentMonthOfDay:(NSDate *)date
{
    NSRange totalDaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totalDaysInMonth.length;
}
//获取上个月月份
- (NSInteger)preInMonth:(NSDate *)date
{
    //获取这个月月份
    NSInteger currentMonth = [self currentMonth:date];
    NSInteger preMonth;
    //判断上一个月是哪个月份
    if (currentMonth == 1) {
        preMonth = 12;
    }else{
        preMonth = currentMonth - 1;
    }
    return preMonth;
}
//获取下个月月份
- (NSInteger)nextMonth:(NSDate *)date
{
    //获取当前月份
    NSInteger currentMonth = [self currentMonth:date];
    NSInteger nextMonth ;
    //判断下一个月份是那个月
    if (currentMonth == 12) {
        nextMonth = 1;
    }else
    {
        nextMonth = currentMonth + 1;
    }
    return nextMonth;
}
//获取上个月份有多少天
- (NSInteger)preInMonthDay:(NSDate *)date
{
    NSInteger currentYear = [self currentYear:date];
    NSInteger preMonth = [self preInMonth:date];
    //判断当前年份是否是闰年
    if (preMonth == 1|| preMonth==3 || preMonth == 5 ||preMonth == 7 || preMonth == 8 || preMonth == 10 || preMonth == 12) {
        return 31;
    }else if (preMonth == 2)
    {
        if ((currentYear%4 == 0 && currentYear%100 !=0) || currentYear %400 ==0) {
            return 29;
        }
        else
        {
            return 28;
        }
    }
    else
    {
        return 30;
    }
}
//获取当前月份的第一天在星期几
- (NSInteger)currentFirstDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayofMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekDay = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayofMonthDate];
    return firstWeekDay - 1;
}
//获取对应月份的天数的数组
- (NSMutableArray *)currentMonthArray:(NSDate *)date
{
    NSMutableArray *dayArray = [NSMutableArray array];
    //获取上一个月是第几月
    NSInteger preMonth = [self preInMonth:date];
    //获取上一个月的天数
    NSInteger preDay = [self preInMonthDay:date];
    //获取下一个月是第几月
    NSInteger nextMonth = [self nextMonth:date];
    //当前月份
    NSInteger currentMonth = [self currentMonth:date];
    //当月第一天是周几
    NSInteger day = [self currentFirstDay:date];
    for (NSInteger i = 0; i < day; i++)
    {
        //存入字典
        NSDictionary *preDic = @{@"month":@(preMonth),@"day":@(preDay - day +i + 1),@"status":@"pre"};
        [dayArray addObject:preDic];
    }
    
    NSInteger days = [self currentMonthOfDay:date];
    for (NSInteger i = 1; i<=days; i++) {
        //存入字典
        NSDictionary *currentDic = @{@"month":@(currentMonth),@"day":@(i),@"status":@"current"};
        [dayArray addObject:currentDic];
    }
    //把剩下的空间置为空
    int lastCount = 1;
    for (NSInteger i = dayArray.count; i<42; i++) {
        //存入字典
        NSDictionary *nextDic = @{@"month":@(nextMonth),@"day":@(lastCount),@"status":@"next"};
        [dayArray addObject:nextDic];
        lastCount ++;
    }
    return dayArray;
}

//获取对应的nsdate和现实的年份月份
-(void)changeCurrentMonth:(NSDate *)date andIndex:(int)index resultData:(void(^)(NSDate *nowDate,NSString *showMonth))block
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = index;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    if (block) {
        block(newDate,[NSString stringWithFormat:@"%li年%li月",(long)[self currentYear:newDate],(long)[self currentMonth:newDate]]);
    }
}
@end

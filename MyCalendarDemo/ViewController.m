//
//  ViewController.m
//  MyCalendarDemo
//
//  Created by 马浩哲 on 16/5/31.
//  Copyright © 2016年 MHZ. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+CalendarSet.h"
#import "CalendarCollectionView.h"
#import "WeekCollectionView.h"
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, strong)NSDate *date;

@property (nonatomic ,strong)UIScrollView *scrollView;

@property (nonatomic, strong)CalendarCollectionView *leftCollectionView;
@property (nonatomic, strong)CalendarCollectionView *centerCollectionView;
@property (nonatomic, strong)CalendarCollectionView *rightCollectionView;

@property (nonatomic, strong)UILabel *dateLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self loadSubviews];
    
   
}

-(void)loadData
{
    self.date = [[NSDate alloc] init];
}

-(void)loadSubviews
{
//    WeekCollectionView *weekCollectionView = [[WeekCollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.width/7)];
//    [self.view addSubview:weekCollectionView];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20 + [[UIScreen mainScreen] bounds].size.width/7, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    for (NSInteger i = 0; i<3; i++) {
        CalendarCollectionView *collectionView = [[CalendarCollectionView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width*i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        collectionView.tag = 1001+i;
        [self.scrollView addSubview:collectionView];
    }
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*3, 0);
    _scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    [self.view addSubview:self.scrollView];
    
    _leftCollectionView = (CalendarCollectionView *)[self.view viewWithTag:1001];
    _centerCollectionView = (CalendarCollectionView *)[self.view viewWithTag:1002];
    _rightCollectionView = (CalendarCollectionView *)[self.view viewWithTag:1003]
    ;
    //初始化数据
    //中间
    _centerCollectionView.allDayMonthArr = [self currentMonthArray:_date];
    //左边
    [self changeCurrentMonth:_date andIndex:-1 resultData:^(NSDate *nowDate, NSString *showMonth) {
        _leftCollectionView.allDayMonthArr = [self currentMonthArray:nowDate];
    }];
    //右边
    [self changeCurrentMonth:_date andIndex:1 resultData:^(NSDate *nowDate, NSString *showMonth) {
        _rightCollectionView.allDayMonthArr = [self currentMonthArray:nowDate];
    }];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2-65, [[UIScreen mainScreen] bounds].size.height -100, 130, 40)];
    [self.view addSubview:_dateLabel];
    _dateLabel.text = [NSString stringWithFormat:@"%li年%li月%li日",[self currentYear:_date],[self currentMonth:_date],[self currentDay:_date]];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.x <=0) {
        self.scrollView.contentOffset =CGPointMake(self.scrollView.frame.size.width, 0);
        //修改数据
        __weak typeof (self)weakSelf = self;
        //中间
        [self changeCurrentMonth:_date andIndex:-1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            weakSelf.centerCollectionView.allDayMonthArr = [weakSelf currentMonthArray:nowDate];
            weakSelf.date = nowDate;
            weakSelf.dateLabel.text = showMonth;
        }];
        //左侧
        [self changeCurrentMonth:_date andIndex:-1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            weakSelf.leftCollectionView.allDayMonthArr = [weakSelf currentMonthArray:nowDate];
        }];
        //右侧
        [self changeCurrentMonth:_date andIndex:1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            weakSelf.rightCollectionView.allDayMonthArr = [weakSelf currentMonthArray:nowDate];
        }];
    }else if (self.scrollView.contentOffset.x >= self.scrollView.frame.size.width*2.0)
    {
        self.scrollView.contentOffset =CGPointMake(self.scrollView.frame.size.width, 0);
        //修改数据
        __weak typeof (self)weakSelf = self;
        //中间
        [self changeCurrentMonth:_date andIndex:1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            weakSelf.centerCollectionView.allDayMonthArr = [weakSelf currentMonthArray:nowDate];
            weakSelf.date = nowDate;
            weakSelf.dateLabel.text = showMonth;
        }];
        //左侧
        [self changeCurrentMonth:_date andIndex:-1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            weakSelf.leftCollectionView.allDayMonthArr = [weakSelf currentMonthArray:nowDate];
        }];
        //右侧
        [self changeCurrentMonth:_date andIndex:1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            weakSelf.rightCollectionView.allDayMonthArr = [weakSelf currentMonthArray:nowDate];
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

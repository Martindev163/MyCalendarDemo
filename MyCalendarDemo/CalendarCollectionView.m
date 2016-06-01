//
//  CalendarCollectionView.m
//  MyCalendarDemo
//
//  Created by 马浩哲 on 16/5/31.
//  Copyright © 2016年 MHZ. All rights reserved.
//

#import "CalendarCollectionView.h"
#import "CalendarCVCell.h"
#import "NSObject+CalendarSet.h"

@interface CalendarCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation CalendarCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.allDayMonthArr = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[CalendarCVCell class] forCellWithReuseIdentifier:@"cell"];
        [self loadLayout];
    }
    return self;
}

-(void)setAllDayMonthArr:(NSMutableArray *)allDayMonthArr
{
    _allDayMonthArr = allDayMonthArr;
    [self reloadData];
}

-(void)loadLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width/7, [[UIScreen mainScreen] bounds].size.width/7);
    [self setCollectionViewLayout:layout];
}


#pragma mark - delegate and datasouce
-(NSInteger)numberOfSections
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 35;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic = self.allDayMonthArr[indexPath.item];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",dic[@"day"]];
    return  cell;
}
@end

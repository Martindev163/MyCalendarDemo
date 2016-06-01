//
//  WeekCollectionView.m
//  MyCalendarDemo
//
//  Created by 马浩哲 on 16/5/31.
//  Copyright © 2016年 MHZ. All rights reserved.
//

#import "WeekCollectionView.h"

@interface WeekCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation WeekCollectionView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dataArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self loadLayout];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel *weekLabel = [[UILabel alloc]initWithFrame:cell.contentView.frame];
    
    
    weekLabel.textAlignment = NSTextAlignmentCenter;
    weekLabel.font = [UIFont systemFontOfSize:12];
    weekLabel.text = self.dataArr[indexPath.item];
    NSLog(@"%li",(long)indexPath.item);
    NSLog(@"%@",self.dataArr[indexPath.item]);
    [cell.contentView addSubview:weekLabel];
    
    return cell;
}

-(void)loadLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.itemSize = CGSizeMake(self.frame.size.width / 7 , self.frame.size.width / 7);
    [self setCollectionViewLayout:layout];
    
}
@end

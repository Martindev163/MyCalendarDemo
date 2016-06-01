//
//  CalendarCVCell.m
//  MyCalendarDemo
//
//  Created by 马浩哲 on 16/5/31.
//  Copyright © 2016年 MHZ. All rights reserved.
//

#import "CalendarCVCell.h"

@implementation CalendarCVCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

-(void)loadUI
{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width-2, self.frame.size.height-2)];
    self.bgView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.bgView];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bgView.frame.size.width, self.bgView.frame.size.height/2)];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.font = [UIFont systemFontOfSize:12];
    [self.bgView addSubview:self.dateLabel];
}

@end

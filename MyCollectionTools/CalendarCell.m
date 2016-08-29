//
//  CalendarCell.m
//  CalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 2 - 12.5, 3, 25, 25)];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setFont:[UIFont systemFontOfSize:16]];
        _dateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_dateLabel];
    }
    return self;
}

@end

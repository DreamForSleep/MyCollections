//
//  AutoLayoutLabelView.m
//  CheckVersion
//
//  Created by 王右 on 16/7/8.
//  Copyright © 2016年 王右. All rights reserved.
//

#import "AutoLayoutLabelView.h"
#import "UIColor+Add.h"

static NSInteger currentRow;
static CGFloat currentX;
static CGFloat currentHeight;

@implementation AutoLayoutLabelView

- (CGFloat)heightWithTextArr:(NSArray *)textArr{
    
    currentHeight = 5;

    [textArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat labelWidth = [self labelWidthWithText:obj];
        CGFloat width = currentX + labelWidth;
        UILabel *label = [[UILabel alloc] init];
        if (width > [UIScreen mainScreen].bounds.size.width) {
            currentRow += 1;
            currentHeight = currentRow * (25 + 5) + 5;
            label.frame = CGRectMake(5, currentHeight, labelWidth, 25);
            currentX = labelWidth + 10;
        }else{
            label.frame = CGRectMake(currentX, currentHeight, labelWidth, 25);
            currentX = labelWidth + currentX + 5;
        }
        //label的边框色
        label.layer.borderColor = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
        label.layer.borderWidth = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = obj;
        //label的字体
        label.font = [UIFont systemFontOfSize:12];
        label.layer.cornerRadius = 5;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        label.tag = 10000 + idx;
        [self addSubview:label];
    }];
    return (currentRow + 1) * (25 + 5) + 5;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        currentHeight = 5;
        currentX = 5;
        currentRow = 0;
    }
    return self;
}

- (CGFloat )labelWidthWithText:(NSString *)string{
    CGSize titleSize = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName, nil]];
    return titleSize.width + 10;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    UILabel *label = (UILabel *)tap.view;
    NSInteger tag = label.tag % 10000;
    if ([_delegate respondsToSelector:@selector(didSelectLabelAtIndex:)]) {
        [_delegate didSelectLabelAtIndex:tag];
    }
}

@end

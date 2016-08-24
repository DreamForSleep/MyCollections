//
//  AutoLayoutLabelView.h
//  CheckVersion
//
//  Created by 王右 on 16/7/8.
//  Copyright © 2016年 王右. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 **字符串内容自适应,自动换行**
*/


@protocol AutoLayoutLabelViewDelegate <NSObject>
//点击事件的代理
- (void)didSelectLabelAtIndex:(NSInteger )index;

@end

@interface AutoLayoutLabelView : UIView
//此方法必须调用,返回self的高度 重新赋值frame 给self
- (CGFloat )heightWithTextArr:(NSArray *)textArr;

@property (nonatomic, weak) id<AutoLayoutLabelViewDelegate> delegate;

@end

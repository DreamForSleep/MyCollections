//
//  UIColor+Add.h
//  CheckVersion
//
//  Created by 王右 on 16/8/24.
//  Copyright © 2016年 王右. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Add)

/*
 **16进制颜色,自带缓存**
*/

+ (UIColor *)colorWithHexString:(NSString *)string;

+ (UIColor *)colorWithHexString:(NSString *)string alpha:(NSInteger )alpha;

+ (UIColor *)randomColor;

@end

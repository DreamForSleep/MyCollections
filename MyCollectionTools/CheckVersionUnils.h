//
//  CheckVersionUnils.h
//  CheckVersion
//
//  Created by 王右 on 16/6/7.
//  Copyright © 2016年 王右. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CheckVersionUnils : NSObject

/*
** 版本判断,是否提示用户更新
** 方法.直接调用 配置在方法内部配置.
*/
+ (void)checkVersion;

@end

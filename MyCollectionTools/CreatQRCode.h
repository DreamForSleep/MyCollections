//
//  CreatQRImage.h
//  CheckVersion
//
//  Created by 王右 on 16/7/6.
//  Copyright © 2016年 王右. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CreatQRCode : NSObject

/*根据参数parm生成二维码图片*/

+ (UIImage *)creatImageWithParm:(NSDictionary *)parm;

/*根据字符串生成二维码图片*/
+ (UIImage *)creatImageWithString:(NSString *)string;
@end

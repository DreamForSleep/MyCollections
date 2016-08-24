//
//  UIColor+Add.m
//  CheckVersion
//
//  Created by 王右 on 16/8/24.
//  Copyright © 2016年 王右. All rights reserved.
//

#import "UIColor+Add.h"

static NSCache *cache;

@implementation UIColor (Add)

+ (UIColor *)colorWithHexString:(NSString *)string{
  return [self colorWithHexString:string alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)string alpha:(NSInteger)alpha{
    
    if (!cache) {
        cache = [[NSCache alloc] init];
    }
    NSString *key = [[self class] cacheKeyWithHexString:string alpha:alpha];
    
    UIColor *targetColor = [cache objectForKey:key];
    
    if (targetColor) {
        return targetColor;
    }

    //过滤字符串
    //去除特殊字符,去除空格
    //大写字符串
    NSString *colorString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] uppercaseString];
    //字符串的长度必须大于或等于6
    if (colorString.length < 6) {
        return [UIColor clearColor];
    }
    //如果是以0X开头,则获取0X之后的字符串
    if ([colorString hasPrefix:@"0X"]){
        colorString = [colorString substringFromIndex:2];
    }
    //如果是以#开头,则获取#之后的字符串
    if ([colorString hasPrefix:@"#"]){
        colorString = [colorString substringFromIndex:1];
    }
    //如果获取之后字符串的长度不为6,则返回透明色
    if ([colorString length] != 6){
        return [UIColor clearColor];
    }
    
    //定义截取字符串范围
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //Red (0,2)
    NSString *redString = [colorString substringWithRange:range];
    
    //Green (2,2)
    range.location = 2;
    NSString *greenString = [colorString substringWithRange:range];
    
    //blue (4,2)
    range.location = 4;
    NSString *blueString = [colorString substringWithRange:range];
    
    //转成10进制数
    unsigned int red, green, blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];

    //返回RGB颜色值
    UIColor *color = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
    
    [cache setName:@"UIColor+Add"];
    [cache setObject:color forKey:key];
    
    return color;
}

+ (UIColor *)randomColor{
    return [UIColor colorWithRed:arc4random_uniform(255) green:arc4random_uniform(255) blue:arc4random_uniform(255) alpha:1];
}

+ (NSString *)cacheKeyWithHexString:(NSString *)string alpha:(NSInteger )alpha{
    return [NSString stringWithFormat:@"%@%ld",string,alpha];
}


@end

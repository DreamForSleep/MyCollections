//
//  CreatQRImage.m
//  CheckVersion
//
//  Created by 王右 on 16/7/6.
//  Copyright © 2016年 王右. All rights reserved.
//

#import "CreatQRCode.h"

@implementation CreatQRCode


+ (UIImage *)creatImageWithParm:(NSDictionary *)parm{
    
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parm options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *qrCodeString = [jsonData base64EncodedStringWithOptions:0];
    //二维码的内容
    NSString *target = [NSString stringWithFormat:@"http://pocketuni.net/QRCode?param=%@",qrCodeString];
    //网页安全
    NSURL *strUrl = [NSURL URLWithString:[target stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSString *targetString = [NSString stringWithFormat:@"%@",strUrl];

    return [self creatQRImageWithString:targetString];
}

+ (UIImage *)creatImageWithString:(NSString *)string{
   return [self creatQRImageWithString:string];
}

+ (UIImage *)creatQRImageWithString:(NSString *)qrString{
    
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
}

//改变二维码大小

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}


@end

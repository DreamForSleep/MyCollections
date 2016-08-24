//
//  CheckVersionUnils.m
//  CheckVersion
//
//  Created by 王右 on 16/6/7.
//  Copyright © 2016年 王右. All rights reserved.
//

#import "CheckVersionUnils.h"

@implementation CheckVersionUnils

+ (void)checkVersion{
    
 
    //id为app的 appleId 不是bundleId
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=你的appleId"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
            
            if (httpRes.statusCode == 200) {
                
                NSError *jsonError;
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:&jsonError];
                
                NSDictionary *newDic = dic[@"results"][0];
                
                NSString *version = newDic[@"version"];
                
                //获取当前设备上的info
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                
                //当前应用版本号
                NSString *app_Version = infoDictionary[@"CFBundleShortVersionString"];
                
                if ([app_Version isEqualToString:version]) {
                    //如果版本号相同
                    return;
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前版本不是最新版本,是否更新" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault)handler:^(UIAlertAction * _Nonnull action) {
                        return ;
                    }];
                    
                    UIAlertAction *determine = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                        
                        //app在appstore中的地址
                        //如何查看: 找到自己的app 右上角按钮 拷贝链接 得到url
                        
                        NSString *appStoreUrl = @"https://appsto.re/cn/fic4O.i";
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreUrl]];
                    }];
                    
                    [alert addAction:cancel];
                    [alert addAction:determine];
                    
                    //回到主线程刷新UI
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                    });
                }
            }
        }
    }];
    [dataTask resume];
}



@end

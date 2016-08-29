//
//  ViewController.m
//  MyCollectionTools
//
//  Created by 王右 on 16/8/24.
//  Copyright © 2016年 王右. All rights reserved.
//

#import "ViewController.h"
#import "CreatQRCode.h"
#import "CalendarPicker.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#warning mark - 生成二维码图片
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:imageView];
//    imageView.image = [CreatQRCode creatImageWithString:@"天下无敌"];
    
#warning mark - 日历
    UIView *calendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 300)];
    CalendarPicker *calendarPicker = [CalendarPicker showOnView:calendarView];
    calendarPicker.today = [NSDate date];
    calendarPicker.date = calendarPicker.today;
    [self.view addSubview:calendarView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  MyCollectionTools
//
//  Created by 王右 on 16/8/24.
//  Copyright © 2016年 王右. All rights reserved.
//

#import "ViewController.h"
#import "CreatQRCode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:imageView];
    imageView.image = [CreatQRCode creatImageWithString:@"天下无敌"];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

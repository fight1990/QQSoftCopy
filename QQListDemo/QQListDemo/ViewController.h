//
//  ViewController.h
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/8.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWTabFirstViewController.h"
#import "PWTabSecondViewController.h"
#import "PWTabThreeViewController.h"
@interface ViewController : UITabBarController

- (void)hideTabBarView:(BOOL)hide; //页面跳转时tabBar的隐藏与显示
@end


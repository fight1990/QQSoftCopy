//
//  PWTabFirstViewController.m
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/8.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "PWTabFirstViewController.h"

@interface PWTabFirstViewController ()<PWRefreshScrollViewDelegate>

@end

@implementation PWTabFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44+StatusBarHeight)];
    titleImageView.image = [UIImage imageNamed:@"backgroundImageOne"];;
    [self.view addSubview:titleImageView];
    
    UIView *titleView = [[UIView alloc] initWithFrame:titleImageView.frame];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.alpha = 0.8;
    [self.view addSubview:titleView];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, StatusBarHeight, 44, 44);
    [leftBtn setTitle:@"左" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(ScreenWidth-44, StatusBarHeight, 44, 44);
    [rightBtn setTitle:@"右" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:rightBtn];
    
    PWScrollView *myView = [[PWScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-53-64)];
    myView.backgroundColor =[UIColor clearColor];
    myView.refreshDelegate = self;
    [self.view addSubview:myView];
}
- (void)refreshDidFinished:(ODRefreshControl*)refreshControl scrollView:(PWScrollView*)scrollView {

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftItemClick:(UIButton*)sender {
    
}

- (void)rightItemClick:(UIButton*)sender {
    
}

@end

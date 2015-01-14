//
//  PWTabThreeViewController.m
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/8.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "PWTabThreeViewController.h"

@interface PWTabThreeViewController ()

@end

@implementation PWTabThreeViewController

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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

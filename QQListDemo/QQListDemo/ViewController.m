//
//  ViewController.m
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/8.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    UIView *tabBarView;
    NSMutableArray *buttons;
    UIImageView *btnBackground;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    PWTabFirstViewController *first = [[PWTabFirstViewController alloc] init];
    PWTabSecondViewController *second = [[PWTabSecondViewController alloc] init];
    PWTabThreeViewController *three = [[PWTabThreeViewController alloc] init];
    
    NSArray *viewArray = @[first,second,three];
    NSMutableArray *navArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    for (int i = 0; i < 3; i++) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[viewArray objectAtIndex:i]];
        [navArray addObject:nav];
    }
    
    CGFloat btnWidth = ScreenWidth/3;
    CGFloat btnHeight = 53;
    
    tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-btnHeight, ScreenWidth, btnHeight)];
    tabBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabBarView"]];
    [self.view addSubview:tabBarView];
    
    btnBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
    btnBackground.backgroundColor = [UIColor clearColor];
    btnBackground.image = [UIImage imageNamed:@"tabBarbackground"];
    btnBackground.alpha = 0.65;
    [tabBarView addSubview:btnBackground];
    
    NSArray *btnNormalImangs = @[@"first_normal",@"second_normal",@"three_normal"];
    NSArray *btnSelectImangs = @[@"first_select",@"second_select",@"three_select"];
    
    buttons = [[NSMutableArray alloc] initWithCapacity:3];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.showsTouchWhenHighlighted = YES;
        btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, btnHeight);
        btn.tag =100+i;
        [btn setImage:[UIImage imageNamed:[btnNormalImangs objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[btnSelectImangs objectAtIndex:i]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [tabBarView addSubview:btn];
        [buttons addObject:btn];
    }
    UIButton *startBtn = [buttons objectAtIndex:0];
    startBtn.selected = YES;
    self.viewControllers = navArray;
}
- (void)clickBtnAction:(UIButton*)sender {
    
    NSInteger index = sender.tag - 100;
    [self clickedBtnSelected:index];
    self.selectedIndex = index;
}
- (void)clickedBtnSelected:(NSInteger)index {
    for (UIButton *btn in buttons) {
        btn.selected = NO;
        btn.userInteractionEnabled = YES;
    }
    UIButton *currentBtn = [buttons objectAtIndex:index];
    currentBtn.selected = YES;
    currentBtn.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        btnBackground.frame = currentBtn.frame;
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)hideTabBarView:(BOOL)hide {
    
    if (hide) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            tabBarView.frame = CGRectMake(tabBarView.frame.origin.x-tabBarView.frame.size.width, tabBarView.frame.origin.y, tabBarView.frame.size.width, tabBarView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            tabBarView.frame = CGRectMake(tabBarView.frame.origin.x+tabBarView.frame.size.width, tabBarView.frame.origin.y, tabBarView.frame.size.width, tabBarView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

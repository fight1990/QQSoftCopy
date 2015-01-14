//
//  PWSliderViewController.h
//  LeftAndRightSlider
//
//  Created by ZHENGBO on 15/1/7.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWSliderViewController : UIViewController

@property (nonatomic, strong)UIViewController *leftViewController; //optional
@property (nonatomic, strong)UIViewController *rightViewController; //optional
@property (nonatomic, strong)UIViewController *centerViewController; //required

//left or right Offset
@property(nonatomic,assign)CGFloat leftContentOffset;
@property(nonatomic,assign)CGFloat rightContentOffset;
//left or right scale
@property(nonatomic,assign)CGFloat leftContentScale;
@property(nonatomic,assign)CGFloat rightContentScale;

+ (PWSliderViewController*)sharedSliderViewController;//instantiationWay

- (void)showMainViewController;
- (void)showLeftViewController;
- (void)showRightViewController;

@end

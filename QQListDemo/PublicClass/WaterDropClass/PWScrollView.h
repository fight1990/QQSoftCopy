//
//  PWScrollView.h
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/9.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODRefreshControl.h"
#import "PWSeparateDelegate.h"

@protocol PWRefreshScrollViewDelegate;
@interface PWScrollView : UIScrollView{
    
    PWSeparateDelegate *separate;
}
@property (nonatomic, assign)id <PWRefreshScrollViewDelegate> refreshDelegate;

@end

//刷新数据
@protocol PWRefreshScrollViewDelegate <NSObject>
- (void)refreshDidFinished:(ODRefreshControl*)refreshControl scrollView:(PWScrollView*)scrollView;
@end


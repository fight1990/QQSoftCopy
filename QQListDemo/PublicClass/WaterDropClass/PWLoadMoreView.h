//
//  PWLoadMoreView.h
//  Day1217
//
//  Created by WeiPengwei on 14/12/17.
//  Copyright (c) 2014年 WeiPengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LOADMORE_VIEW_HIGHT 30.0f
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

typedef enum{
    PWLoadMoreNormal=0,
    PWLoadMorePulling,
    PWLoadMoreLoading,
    
}PWLoadMoreState;//下拉状态
@protocol PWLoadMoreDelegate;
@interface PWLoadMoreView : UIView{

    UILabel *stateLabel;  //上拉状态标签
    UIActivityIndicatorView *activityView; //加载锯齿
    PWLoadMoreState loadMoreState;
    
    BOOL isLoading;
    
    UIScrollView *myScrollView;
}
@property (nonatomic, assign) id <PWLoadMoreDelegate>loadMoreDelegate;
//图形初始化
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame stateColor:(UIColor*)stateColor;

- (void)loadMoreScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)loadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)loadMoreScrollViewWillBeginDragging:(UIScrollView *)scrollView;

- (void)stopAnimation ;
@end


@protocol PWLoadMoreDelegate <NSObject>
- (void)loadMoreViewDidFinished:(PWLoadMoreView*)loadMoreView;

@end
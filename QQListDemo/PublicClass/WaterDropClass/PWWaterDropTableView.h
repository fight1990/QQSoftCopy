//
//  PWWaterDropTableView.h
//  PWTableView-WaterDrop
//
//  Created by ZHENGBO on 14/12/18.
//  Copyright (c) 2014年 WeiPengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODRefreshControl.h"
#import "PWLoadMoreView.h"
#import "PWSeparateDelegate.h"
@protocol PWRefreshDataDelegate;
@protocol PWLoadMoreDataDelegate;
@interface PWWaterDropTableView : UITableView<PWLoadMoreDelegate>{

    PWLoadMoreView *myLoadMoreView;
    PWSeparateDelegate *separate;
}
@property (nonatomic, assign)id <PWRefreshDataDelegate> refreshDataDelegate;
@property (nonatomic, assign)id <PWLoadMoreDataDelegate> loadMoreDataDelegate;
@property (nonatomic, assign)BOOL isNoMore;

@end

//刷新数据
@protocol PWRefreshDataDelegate <NSObject>
- (void)refreshDidFinished:(ODRefreshControl*)refreshControl scrollView:(PWWaterDropTableView*)tableView;
@end

//加载更多数据
@protocol PWLoadMoreDataDelegate <NSObject>
- (void)loadMoreViewDidFinished:(PWLoadMoreView*)loadMoreView scrollView:(PWWaterDropTableView*)tableView;
@end


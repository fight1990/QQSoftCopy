//
//  PWWaterDropTableView.m
//  PWTableView-WaterDrop
//
//  Created by ZHENGBO on 14/12/18.
//  Copyright (c) 2014年 WeiPengwei. All rights reserved.
//

#import "PWWaterDropTableView.h"

@implementation PWWaterDropTableView
@synthesize refreshDataDelegate = _refreshDataDelegate;
@synthesize loadMoreDataDelegate = _loadMoreDataDelegate;

- (id)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initialize];
    }
    
    return self;
}
- (void)initialize {

    separate = [[PWSeparateDelegate alloc] init];
    separate.middleDelegate = self;
    separate.receiverDelegate = self.delegate;
    super.delegate = (id)separate;
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    //添加刷新头
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self];
    refreshControl.backgroundColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    if (!_isNoMore) {
        myLoadMoreView = [[PWLoadMoreView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        [myLoadMoreView setBackgroundColor:[UIColor whiteColor]];
        myLoadMoreView.loadMoreDelegate = self;
        [self addSubview:myLoadMoreView];
    }
    
}
- (void)setIsNoMore:(BOOL)isNoMore {
    _isNoMore = isNoMore;
    if (_isNoMore) {
        [myLoadMoreView removeFromSuperview];
        myLoadMoreView = nil;
    }
}
- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    if(separate) {
        super.delegate = nil;
        separate.receiverDelegate = delegate;
        super.delegate = (id)separate;
    } else {
        super.delegate = delegate;
    }
}
- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGFloat visibleTableDiffBoundsHeight = (self.bounds.size.height - MIN(self.bounds.size.height, self.contentSize.height));
    
    CGRect loadMoreFrame = myLoadMoreView.frame;
    loadMoreFrame.origin.y = self.contentSize.height + visibleTableDiffBoundsHeight;
    myLoadMoreView.frame = loadMoreFrame;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [myLoadMoreView loadMoreScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [myLoadMoreView loadMoreScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [myLoadMoreView loadMoreScrollViewWillBeginDragging:scrollView];
}

#pragma PWLoadMoreDelegate
- (void)loadMoreViewDidFinished:(PWLoadMoreView*)loadMoreView{
    //FIXME
    /*double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [loadMoreView stopAnimation];
    });*/
    
    if (_loadMoreDataDelegate && [_loadMoreDataDelegate respondsToSelector:@selector(loadMoreViewDidFinished:scrollView:)]){
        [_loadMoreDataDelegate loadMoreViewDidFinished:loadMoreView scrollView:self];
    }
}


#pragma refreshDelegate
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl {
    
    if (_refreshDataDelegate && [_refreshDataDelegate respondsToSelector:@selector(refreshDidFinished:scrollView:)]) {
        [_refreshDataDelegate refreshDidFinished:refreshControl scrollView:self];
    }
    
}
@end

//
//  PWScrollView.m
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/9.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "PWScrollView.h"

@implementation PWScrollView

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
    
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height+2);
}

#pragma refreshDelegate
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl {
    //FIXME
    /*double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refreshControl endRefreshing];
    });*/
    
    if (_refreshDelegate && [_refreshDelegate respondsToSelector:@selector(refreshDidFinished:scrollView:)]) {
        [_refreshDelegate refreshDidFinished:refreshControl scrollView:self];
    }
    
}

@end

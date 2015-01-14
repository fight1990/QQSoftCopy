//
//  PWLoadMoreView.m
//  Day1217
//
//  Created by WeiPengwei on 14/12/17.
//  Copyright (c) 2014年 WeiPengwei. All rights reserved.
//

#import "PWLoadMoreView.h"

@implementation PWLoadMoreView
@synthesize loadMoreDelegate=_loadMoreDelegate;

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame stateColor:nil];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame stateColor:(UIColor*)stateColor {
    self = [super initWithFrame:frame];
    if (self) {
        isLoading = NO;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 5, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textColor = stateColor ? stateColor : [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        stateLabel=label;
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(0.0f,5, 20.0f, 20.0f);
        view.center = CGPointMake(self.center.x-50, 15);
        [self addSubview:view];
        activityView = view;
        
        [self setState:PWLoadMoreNormal];
        
    }
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    stateLabel.center = CGPointMake(self.frame.size.width/2, 15);

}
- (void)setState:(PWLoadMoreState)aState{
    
    switch (aState) {
        case PWLoadMorePulling:
            
            stateLabel.text = @"松开后加载更多";
            
            break;
        case PWLoadMoreNormal:
            
            stateLabel.text = @"上拉加载更多";
            [activityView stopAnimating];
            
            break;
        case PWLoadMoreLoading:
            
            stateLabel.text = @"加载中...";
            [activityView startAnimating];
            break;
        default:
            break;
    }
    
    loadMoreState = aState;
}
- (void)stopAnimation {
    [self stopAnimatingWithScrollView:myScrollView];
}
- (void)stopAnimatingWithScrollView:(UIScrollView *) scrollView {
    isLoading = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.bottom = 0;
    scrollView.contentInset = currentInsets;
    [UIView commitAnimations];
    
    [self setState:PWLoadMoreNormal];
    
    
}

- (void)startAnimatingWithScrollView:(UIScrollView *) scrollView {
    myScrollView = scrollView;
    isLoading = YES;
    [self setState:PWLoadMoreLoading];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.bottom = LOADMORE_VIEW_HIGHT + [self visibleTableHeightDiffWithBoundsHeight:scrollView];
    scrollView.contentInset = currentInsets;
    [UIView commitAnimations];
    if([self scrollViewOffsetFromBottom:scrollView] == 0){
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + LOADMORE_VIEW_HIGHT) animated:YES];
    }
    
}

- (CGFloat)scrollViewOffsetFromBottom:(UIScrollView *) scrollView {
    CGFloat scrollAreaContenHeight = scrollView.contentSize.height;
    
    CGFloat visibleTableHeight = MIN(scrollView.bounds.size.height, scrollAreaContenHeight);
    CGFloat scrolledDistance = scrollView.contentOffset.y + visibleTableHeight;
    CGFloat normalizedOffset = scrollAreaContenHeight -scrolledDistance;
    
    return normalizedOffset;
    
}

- (CGFloat)visibleTableHeightDiffWithBoundsHeight:(UIScrollView *) scrollView {
    return (scrollView.bounds.size.height - MIN(scrollView.bounds.size.height, scrollView.contentSize.height));
}
- (void)loadMoreScrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat bottomOffset = [self scrollViewOffsetFromBottom:scrollView];
    if (loadMoreState == PWLoadMoreLoading) {
        
        CGFloat offset = MAX(bottomOffset * -1, 0);
        offset = MIN(offset, LOADMORE_VIEW_HIGHT);
        UIEdgeInsets currentInsets = scrollView.contentInset;
        currentInsets.bottom = offset? offset + [self visibleTableHeightDiffWithBoundsHeight:scrollView]: 0;
        scrollView.contentInset = currentInsets;
        
    } else if (scrollView.isDragging) {
        if (loadMoreState == PWLoadMorePulling && bottomOffset > -LOADMORE_VIEW_HIGHT && bottomOffset < 0.0f && !isLoading) {
            [self setState:PWLoadMoreNormal];
        } else if (loadMoreState == PWLoadMoreNormal && bottomOffset < -LOADMORE_VIEW_HIGHT && !isLoading) {
            [self setState:PWLoadMorePulling];
            
        }
        
        if (scrollView.contentInset.bottom != 0) {
            UIEdgeInsets currentInsets = scrollView.contentInset;
            currentInsets.bottom = 0;
            scrollView.contentInset = currentInsets;
        }
        
    }

}
- (void)loadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if ([self scrollViewOffsetFromBottom:scrollView] <= - LOADMORE_VIEW_HIGHT && !isLoading) {
        [self startAnimatingWithScrollView:scrollView];
        if (_loadMoreDelegate && [_loadMoreDelegate respondsToSelector:@selector(loadMoreViewDidFinished:)]) {
            
            [_loadMoreDelegate loadMoreViewDidFinished:self];
            
        }
        
    }
    
}
- (void)loadMoreScrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}


@end

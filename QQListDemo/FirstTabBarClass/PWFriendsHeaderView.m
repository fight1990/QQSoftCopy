//
//  PWFriendsHeaderView.m
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/9.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "PWFriendsHeaderView.h"

@interface PWFriendsHeaderView () <UISearchBarDelegate>{

    UISearchBar *searchBar; //tag = 100;
    
    NSArray *btnImagesNormal; //正常状态图标
    NSArray *btnImagesHighlighted; //高亮图标
    
    
}

@end

@implementation PWFriendsHeaderView

- (id)initWithFrame:(CGRect)frame btnImagesNormal:(NSArray*)imagesNormal btnImagesHighlighted:(NSArray*)imagesHighlighted {
    self = [super initWithFrame:frame];
    if (self) {
        btnImagesNormal = [[NSArray alloc] initWithArray:imagesNormal];
        btnImagesHighlighted = [[NSArray alloc] initWithArray:imagesHighlighted];
        [self initialization];
    }
    return self;
}

- (void)initialization {

    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.placeholder = @"搜索";
    searchBar.tag =100;
    searchBar.alpha = 0.75;
    [self addSubview:searchBar];
    
    NSInteger btnCount = btnImagesNormal.count;
    CGFloat origin_y = searchBar.frame.origin.y + searchBar.frame.size.height;
    CGFloat btnWidth = self.frame.size.width / btnCount;
    for (int i =0; i<btnCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnWidth*i, origin_y, btnWidth, btnWidth);
        btn.showsTouchWhenHighlighted = YES;
        btn.tag = 100+i;
        [btn setImage:[UIImage imageNamed:[btnImagesNormal objectAtIndex:i]] forState:UIControlStateNormal];
        if (btnImagesHighlighted.count > i) {
            [btn setImage:[UIImage imageNamed:[btnImagesHighlighted objectAtIndex:i]] forState:UIControlStateHighlighted];
        }
        else{
            [btn setBackgroundImage:[self drawBackgroundImage] forState:UIControlStateHighlighted];
        }
        [btn addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
    UILabel *classLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, origin_y + btnWidth, self.frame.size.width, 20)];
    classLabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    classLabel.text = @"    好友分组";
    //classLabel.alpha = 0.5;
    classLabel.textColor = [UIColor grayColor];
    classLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [self addSubview:classLabel];
    
    CGFloat height = searchBar.frame.origin.y +searchBar.frame.size.height + btnWidth + 20;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    
}
- (void)btnClickedAction:(id)sender {
    UIButton * button = (UIButton*)sender;
    if (_clickedDelegate && [_clickedDelegate respondsToSelector:@selector(buttonClicked:buttonIndex:)]) {
        [_clickedDelegate buttonClicked:self buttonIndex:(button.tag - 100)];
    }
    
}
- (UIImage*)drawBackgroundImage {
    UIGraphicsBeginImageContext(CGSizeMake(40, 40));
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(contextRef, 0.95, 0.95, 0.95, 0.95);
    CGContextFillRect(contextRef, CGRectMake(0, 0, 40, 40));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
- (void)setSearchDelegate:(id)searchDelegate {
    _searchDelegate = searchDelegate;
    searchBar.delegate = searchDelegate;
}
- (void)dealloc {

    searchBar = nil;
    btnImagesNormal = nil;
    btnImagesHighlighted = nil;
}
@end

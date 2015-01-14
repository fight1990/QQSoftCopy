//
//  PWSearchView.h
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/12.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionHeaderObject.h"
#import "TableViewObject.h"
#import "PWFriendsDetailViewController.h"
@interface PWSearchView : UIView

@property(nonatomic, strong)UISearchBar *searchBar;
@property(nonatomic, strong)NSArray *sourceDatas;
- (void)animationDidHideView ;
@end

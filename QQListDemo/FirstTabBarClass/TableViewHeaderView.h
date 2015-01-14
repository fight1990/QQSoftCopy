//
//  TableViewHeaderView.h
//  QQTableViewSimulate
//
//  Created by ZHENGBO on 15/1/6.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionHeaderObject.h"
@protocol TableViewHeaderDelegate ;
@interface TableViewHeaderView : UITableViewHeaderFooterView

@property (nonatomic,assign)id <TableViewHeaderDelegate> delegate;
@property (nonatomic,strong)SectionHeaderObject *headerObject;

+ (instancetype)initWithHeaderView:(UITableView*)tableView;
@end

@protocol TableViewHeaderDelegate<NSObject>
- (void)clickedAction:(TableViewHeaderView*)headerView;
@end

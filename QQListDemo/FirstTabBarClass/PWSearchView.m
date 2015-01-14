//
//  PWSearchView.m
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/12.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "PWSearchView.h"

@interface PWSearchView ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * resultDatas;
    UITableView *resultTableView;
}


@end

@implementation PWSearchView

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {

    self.opaque = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.placeholder = @"搜索";
    _searchBar.alpha = 0.75;
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    [self addSubview:_searchBar];
    
    [_searchBar becomeFirstResponder];
    
    resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-44) style:UITableViewStylePlain];
    resultTableView.delegate = self;
    resultTableView.dataSource = self;
    [self addSubview:resultTableView];
    resultTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    resultTableView.rowHeight = 44;
    
}
#pragma UITableViewDataDelegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return resultDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
        
    TableViewObject *object = [resultDatas objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:@"jingtian"];
    cell.imageView.layer.cornerRadius = 30;
    cell.imageView.layer.masksToBounds = YES;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ -> %@",object.name,object.type];
    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self animationDidHideView];
    PWFriendsDetailViewController *friendsDetail = [[PWFriendsDetailViewController alloc] init];
    [[PWSliderViewController sharedSliderViewController].navigationController pushViewController:friendsDetail animated:YES];
}
- (void)animationDidHideView {
    [UIView animateWithDuration:0.05 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, ScreenHeight);
        self.superview.transform = CGAffineTransformIdentity;
        [_searchBar resignFirstResponder];
    }];
    resultDatas = nil;
    [resultTableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSThread detachNewThreadSelector:@selector(getSearchResultDatas:) toTarget:self withObject:searchText];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self animationDidHideView];
}
- (void)getSearchResultDatas:(NSString*)searchText {

    if (resultDatas) {
        resultDatas = nil;
    }
    resultDatas = [[NSMutableArray alloc] init];
    for (SectionHeaderObject *sho in _sourceDatas) {
        for (TableViewObject *tvo in sho.friends) {
            if ([tvo.name containsString:searchText] || [tvo.say containsString:searchText]) {
                TableViewObject *resultObject = tvo;
                resultObject.type = sho.title;
                [resultDatas addObject:resultObject];
            }
        }
    }
    [resultTableView reloadData];
}
@end

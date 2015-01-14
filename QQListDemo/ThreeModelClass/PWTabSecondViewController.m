//
//  PWTabSecondViewController.m
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/8.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "PWTabSecondViewController.h"
#import "PWFriendsDetailViewController.h"
#define HeaderViewHeight 120

@interface PWTabSecondViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewHeaderDelegate,PWRefreshDataDelegate,PWClickedDelegate> {
    
    PWWaterDropTableView *listmanTableView;
    NSArray *cellsArray;
    
    PWFriendsHeaderView *friendHeaderView;
    PWSearchView * searchView;
}



@end

@implementation PWTabSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44+StatusBarHeight)];
    titleImageView.image = [UIImage imageNamed:@"backgroundImageOne"];;
    [self.view addSubview:titleImageView];
    
    UIView *titleView = [[UIView alloc] initWithFrame:titleImageView.frame];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.alpha = 0.8;
    [self.view addSubview:titleView];
   
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(ScreenWidth-44, StatusBarHeight, 44, 44);
    [rightBtn setTitle:@"右" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:rightBtn];
    
    NSArray *normalImages = [NSArray arrayWithObjects:@"first_normal",@"second_normal",@"three_normal",@"first_normal", nil];
    NSArray *highlightedImages = [NSArray arrayWithObjects: nil];
    
    friendHeaderView = [[PWFriendsHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeaderViewHeight) btnImagesNormal:normalImages btnImagesHighlighted:highlightedImages];
    friendHeaderView.searchDelegate = self;
    friendHeaderView.clickedDelegate = self;
    
    listmanTableView = [[PWWaterDropTableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-53) style:UITableViewStylePlain];
    listmanTableView.backgroundColor = [UIColor clearColor];
    listmanTableView.dataSource = self;
    listmanTableView.delegate = self;
    listmanTableView.refreshDataDelegate =self;
    listmanTableView.isNoMore = YES;
    [self.view addSubview:listmanTableView];
    listmanTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    listmanTableView.rowHeight = 60;
    //listmanTableView.scrollEnabled = NO;
    //listmanTableView.sectionHeaderHeight = 44;
    
    [NSThread detachNewThreadSelector:@selector(getTableCellDatas) toTarget:self withObject:nil];

}
- (void)getTableCellDatas {
    if (!cellsArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friendsList.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *muArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array) {
            SectionHeaderObject *HeaderObject = [SectionHeaderObject initWithDictionary:dict];
            [muArray addObject:HeaderObject];
        }
        cellsArray = [[NSArray alloc] initWithArray:muArray];
    }
    [listmanTableView reloadData];
}
#pragma --  RefreshScrollView

#pragma - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return  0;
    }
    else {
        SectionHeaderObject *object = [cellsArray objectAtIndex:(section - 1)];
        if (object.isFold) {
            return 0;
        }
        return object.friends.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (!section) {
        return friendHeaderView.frame.size.height;
    }
    else {
        return 44;
    }
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
    if (indexPath.section) {
        
        SectionHeaderObject *headerObject = [cellsArray objectAtIndex:(indexPath.section - 1)];
        TableViewObject *object = [headerObject.friends objectAtIndex:indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:@"jingtian"];
        cell.imageView.layer.cornerRadius = 30;
        cell.imageView.layer.masksToBounds = YES;
        
        cell.textLabel.text = object.name;
        cell.detailTextLabel.text = object.say;
    }
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return cellsArray.count+1;
}

#pragma - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!section) {
        return friendHeaderView;
    }
    else {
        TableViewHeaderView *headerView = [TableViewHeaderView initWithHeaderView:tableView];
        headerView.delegate = self;
        headerView.headerObject = [cellsArray objectAtIndex:(section-1)];
        
        return headerView;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PWFriendsDetailViewController *friendsDetail = [[PWFriendsDetailViewController alloc] init];
    [[PWSliderViewController sharedSliderViewController].navigationController pushViewController:friendsDetail animated:YES];
}
- (void)refreshDidFinished:(ODRefreshControl*)refreshControl scrollView:(PWWaterDropTableView*)tableView {
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refreshControl endRefreshing];
    });
}
- (void)clickedAction:(TableViewHeaderView*)headerView {
    [listmanTableView reloadData];
}
- (void)rightItemClick:(UIButton*)sender {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)buttonClicked:(PWFriendsHeaderView*)view buttonIndex:(NSInteger)index {

    NSLog(@"%ld",(long)index);
}
- (void)viewDidSearchView {

    if (!searchView) {
        
        searchView = [[PWSearchView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 20)];
        searchView.backgroundColor = [UIColor whiteColor];
         searchView.sourceDatas = [[NSArray alloc] initWithArray:cellsArray];
        [self.view addSubview:searchView];
    }
    else {
       [UIView animateWithDuration:0.02 animations:^{
          searchView.transform = CGAffineTransformIdentity;
          [searchView.searchBar becomeFirstResponder];
          searchView.searchBar.text = nil;
       }];
    }
}
#pragma searchBar
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (searchBar.tag == 100) {
        [UIView animateWithDuration:0.45 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -44);
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self viewDidSearchView];
        });
        return NO;
    }
    else {
        return YES;
    }
}



@end

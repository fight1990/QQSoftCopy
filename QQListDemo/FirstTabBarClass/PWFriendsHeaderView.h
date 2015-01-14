//
//  PWFriendsHeaderView.h
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/9.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PWClickedDelegate;
@interface PWFriendsHeaderView : UIView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, assign) id searchDelegate;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) id <PWClickedDelegate>clickedDelegate;

- (id)initWithFrame:(CGRect)frame btnImagesNormal:(NSArray*)imagesNormal btnImagesHighlighted:(NSArray*)imagesHighlighted;
@end
@protocol PWClickedDelegate <NSObject>

- (void)buttonClicked:(PWFriendsHeaderView*)view buttonIndex:(NSInteger)index;
@end
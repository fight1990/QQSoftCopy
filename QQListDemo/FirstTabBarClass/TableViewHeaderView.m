//
//  TableViewHeaderView.m
//  QQTableViewSimulate
//
//  Created by ZHENGBO on 15/1/6.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "TableViewHeaderView.h"

@interface TableViewHeaderView (){

    UIButton *button;
    UILabel *statusLabel;
}

@end

@implementation TableViewHeaderView

+ (instancetype)initWithHeaderView:(UITableView*)tableView {

    static NSString *identifier = @"header";
    TableViewHeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!headerView) {
        headerView = [[TableViewHeaderView alloc] initWithReuseIdentifier:identifier];
    }
    
    return headerView;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    if (self) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tableBtnNormal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tableBtnHigh"] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"trigon"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.imageView.contentMode = UIViewContentModeCenter;
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button = btn;
        [self addSubview:button];
        
        //创建标签
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentRight;
        statusLabel = label;
        [self addSubview:statusLabel];
        
    }
    return self;
}
- (void)setHeaderObject:(SectionHeaderObject *)headerObject {
    _headerObject = headerObject;
    [button setTitle:[NSString stringWithFormat:@"%@",_headerObject.title] forState:UIControlStateNormal];
    statusLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)_headerObject.online,(unsigned long)_headerObject.friends.count];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    button.frame = self.bounds;
    statusLabel.frame = CGRectMake(ScreenWidth-130, 0, 120, self.frame.size.height);
    
}
- (void)buttonAction:(UIButton*)sender {
    _headerObject.isFold = !_headerObject.isFold;
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickedAction:)]) {
        [_delegate clickedAction:self];
    }
}
- (void)didMoveToSuperview {
    button.imageView.transform = _headerObject.isFold ? CGAffineTransformMakeRotation(0) : CGAffineTransformMakeRotation(M_PI_2);
}

@end

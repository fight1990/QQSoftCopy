//
//  SectionHeaderObject.h
//  QQTableViewSimulate
//
//  Created by ZHENGBO on 15/1/6.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SectionHeaderObject : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger online;
@property (nonatomic, copy) NSArray *friends;
@property (nonatomic, assign) BOOL isFold;

+ (instancetype)initWithDictionary:(NSDictionary*)dic;
- (instancetype)initWithDictionary:(NSDictionary*)dic;
@end

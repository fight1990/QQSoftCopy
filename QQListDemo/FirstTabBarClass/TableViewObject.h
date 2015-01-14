//
//  TableViewObject.h
//  QQTableViewSimulate
//
//  Created by ZHENGBO on 15/1/6.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewObject : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *say;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign)BOOL online;

+ (instancetype)initWithDictionary:(NSDictionary*)dic;
- (instancetype)initWithDictionary:(NSDictionary*)dic;

@end

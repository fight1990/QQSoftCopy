//
//  TableViewObject.m
//  QQTableViewSimulate
//
//  Created by ZHENGBO on 15/1/6.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "TableViewObject.h"

@implementation TableViewObject

+ (instancetype)initWithDictionary:(NSDictionary*)dic {
    return [[self alloc]initWithDictionary:dic];
}
- (instancetype)initWithDictionary:(NSDictionary*)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

@end

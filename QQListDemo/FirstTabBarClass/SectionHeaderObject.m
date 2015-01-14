//
//  SectionHeaderObject.m
//  QQTableViewSimulate
//
//  Created by ZHENGBO on 15/1/6.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "SectionHeaderObject.h"
#import "TableViewObject.h"
@implementation SectionHeaderObject

+ (instancetype)initWithDictionary:(NSDictionary*)dic {
    return [[self alloc]initWithDictionary:dic];
}
- (instancetype)initWithDictionary:(NSDictionary*)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        NSMutableArray *friendsArray = [[NSMutableArray alloc] init];
        for (NSDictionary *friendDic in self.friends) {
            TableViewObject *object = [TableViewObject initWithDictionary:friendDic];
            [friendsArray addObject:object];
            if (object.online) {
                self.online ++;
            }
        }
        self.friends = friendsArray;
        self.isFold = YES;
        
    }
    
    return self;
}

@end

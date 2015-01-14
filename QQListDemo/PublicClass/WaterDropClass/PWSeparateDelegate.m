//
//  PWSeparateDelegate.m
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/9.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "PWSeparateDelegate.h"

@implementation PWSeparateDelegate

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([_middleDelegate respondsToSelector:aSelector]) { return _middleDelegate; }
    if ([_receiverDelegate respondsToSelector:aSelector]) { return _receiverDelegate; }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([_middleDelegate respondsToSelector:aSelector]) { return YES; }
    if ([_receiverDelegate respondsToSelector:aSelector]) { return YES; }
    return [super respondsToSelector:aSelector];
}

@end

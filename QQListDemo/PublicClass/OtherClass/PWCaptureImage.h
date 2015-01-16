//
//  PWCaptureImage.h
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/14.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//
//实现当前页面的截图
#import <Foundation/Foundation.h>

@interface PWCaptureImage : NSObject

+ (UIImage*)captureImageFromView:(UIView*)view ;
@end

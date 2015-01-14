//
//  PWCaptureImage.m
//  QQListDemo
//
//  Created by ZHENGBO on 15/1/14.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "PWCaptureImage.h"

@implementation PWCaptureImage

+ (UIImage*)captureImageFromView:(UIView*)view {
    CGRect screenRect = view.bounds;
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

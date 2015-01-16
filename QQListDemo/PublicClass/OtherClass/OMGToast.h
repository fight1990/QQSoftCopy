//
//  OMGToast.h
//  TianYiFoodBasket
//
//  Created by fucheng zhou on 12-4-25.
//  Copyright (c) 2012年 sr. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEFAULT_DISPLAY_DURATION 2.0f
@interface OMGToast : NSObject{
    NSString *text;  
    UIButton *contentView;  
    CGFloat  duration; 
}
+ (void)showWithText:(NSString *) text_;  
+ (void)showWithText:(NSString *) text_  
            duration:(CGFloat)duration_;  

+ (void)showWithText:(NSString *) text_  
           topOffset:(CGFloat) topOffset_;  
+ (void)showWithText:(NSString *) text_  
           topOffset:(CGFloat) topOffset  
            duration:(CGFloat) duration_;  

+ (void)showWithText:(NSString *) text_  
        bottomOffset:(CGFloat) bottomOffset_; 
+ (void)showWithText:(NSString *) text_  
        bottomOffset:(CGFloat) bottomOffset_  
            duration:(CGFloat) duration_; 
+ (void)showWithTextOnThread:(NSString *)text_  
                    duration:(CGFloat)duration_;
@end

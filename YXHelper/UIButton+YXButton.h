//
//  UIButton+YXButton.h
//  YXHelper
//
//  Created by cximac on 2019/12/16.
//  Copyright © 2019 littleLione. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "objc/runtime.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (YXButton)

//默认时间间隔
#define defaultInterval 2
//点击间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;
//用于设置单个按钮不需要被hook
@property (nonatomic, assign) BOOL isIgnore;

@end

NS_ASSUME_NONNULL_END

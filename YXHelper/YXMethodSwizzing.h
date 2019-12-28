//
//  YXMethodSwizzing.h
//  YXHelper
//
//  Created by cximac on 2019/12/16.
//  Copyright © 2019 littleLione. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "objc/runtime.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXMethodSwizzing : NSObject


+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector;

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);

@end

NS_ASSUME_NONNULL_END

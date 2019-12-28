//
//  YXMethodSwizzing.m
//  YXHelper
//
//  Created by cximac on 2019/12/16.
//  Copyright © 2019 littleLione. All rights reserved.
//

#import "YXMethodSwizzing.h"


@implementation YXMethodSwizzing

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector{
    Class class = [self class];
    //原有方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    //替换原有方法的新方法
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况，如果这方法已存在则返回No
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {//添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {//添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
       Method originalMethod = class_getInstanceMethod(class, originalSelector);
       Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
       
       // class_addMethod will fail if original method already exists
       BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
       
       // the method doesn’t exist and we just added one
       if (didAddMethod) {
           class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
       }
       else {
           method_exchangeImplementations(originalMethod, swizzledMethod);
       }
}


@end

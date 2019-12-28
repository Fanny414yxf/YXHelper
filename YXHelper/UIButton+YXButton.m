//
//  UIButton+YXButton.m
//  YXHelper
//
//  Created by cximac on 2019/12/16.
//  Copyright © 2019 littleLione. All rights reserved.
//

#import "UIButton+YXButton.h"

#import <UIKit/UIKit.h>
#import "YXMethodSwizzing.h"


@implementation UIButton (YXButton)

+ (void)load
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        
        swizzleMethod([self class], @selector(sendAction:to:forEvent:), @selector(yx_sendAction:to:forEvent:));
    });
}


- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)timeInterval
{
   return [objc_getAssociatedObject(self, _cmd) doubleValue];
}


- (void)setIsIgnore:(BOOL)isIgnore
{
    objc_setAssociatedObject(self, @selector(isIgnore), @(isIgnore), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)isIgnore
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent
{
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)isIgnoreEvent
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}


// 需要替换的方法
- (void)yx_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.isIgnore) {
        [self yx_sendAction:action to:target forEvent:event];
        return;
    }
    self.timeInterval = self.timeInterval==0? defaultInterval : self.timeInterval;
    if (self.isIgnoreEvent) {
        return;
    }else if (self.timeInterval > 0){
        self.isIgnoreEvent = YES;
        [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
    }
    //此处 methodA和methodB方法IMP互换了，实际上执行 sendAction；所以不会死循环
    
    [self yx_sendAction:action to:target forEvent:event];
}

- (void)resetState
{
    [self setIsIgnoreEvent:NO];
}

@end

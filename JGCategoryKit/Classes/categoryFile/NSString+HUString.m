//
//  NSString+HUString.m
//  317hu
//
//  Created by wanggang on 2018/4/8.
//  Copyright © 2018年 wanggang. All rights reserved.
//
//防止截取字符串越界崩溃

#import "NSString+HUString.h"
#import <objc/message.h>

@implementation NSString (HUString)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSCFString");
        Method oldMethod = class_getInstanceMethod(class, @selector(substringFromIndex:));
        Method newMethod = class_getInstanceMethod(class, @selector(hu_substringFromIndex:));
        if (oldMethod && newMethod) {
            method_exchangeImplementations(oldMethod, newMethod);
        }
        
        Method oldM = class_getInstanceMethod(class, @selector(substringToIndex:));
        Method newM = class_getInstanceMethod(class, @selector(hu_substringToIndex:));
        if (oldM && newM) {
            method_exchangeImplementations(oldM, newM);
        }
    });
}

- (NSString *)hu_substringFromIndex:(NSUInteger)from{
    if (self.length<from) {
        NSLog(@"字符串substringFromIndex方法越界");
        return @"";
    }else{
        return [self hu_substringFromIndex:from];
    }
}

- (NSString *)hu_substringToIndex:(NSUInteger)to{
    if (self.length <to) {
        NSLog(@"字符串substringToIndex方法越界");
        return self;
    }else{
        return [self hu_substringToIndex:to];
    }
}

@end

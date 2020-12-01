//
//  NSArray+Wgarray.m
//  317hu
//
//  Created by wanggang on 2018/3/28.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import "NSArray+Wgarray.h"
#import <objc/message.h>

@implementation NSArray (Wgarray)

+(void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //注意：有个坑，很可能造成不走你交换的方法：class名字确定最好不要用[self class]，他的确定可以从崩溃日至那里来确定，例如这个__NSArrayI类名的确认是从崩溃日志'*** -[__NSArrayI objectAtIndexedSubscript:]: index 3 beyond bounds [0 .. 2]'来确定的
        Class class = NSClassFromString(@"__NSArrayI");
        Method oldMethod = class_getInstanceMethod(class, @selector(objectAtIndexedSubscript:));
        Method newMethod = class_getInstanceMethod(class, @selector(wg_objectAtIndexedSubscript:));
        if (oldMethod && newMethod) {
            method_exchangeImplementations(oldMethod, newMethod);
        }
    });
}

- (id)wg_objectAtIndexedSubscript:(NSUInteger)index{
    if (!self.count || self.count - 1 < index) {
        NSLog(@"objectAtIndexedSubscript越界");
        return nil;
    }else{
        id obj = [self wg_objectAtIndexedSubscript:index];
        return obj;
    }
}
@end


@implementation NSMutableArray (Wgarray)

+(void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //注意：他的确定可以从崩溃日至那里来确定，这个__NSArrayM类名的确认是从崩溃日志'*** -[__NSArrayM objectAtIndexedSubscript:]: index 6 beyond bounds [0 .. 2]'来确定的
        Class class = NSClassFromString(@"__NSArrayM");
        Method oldMethod = class_getInstanceMethod(class, @selector(objectAtIndexedSubscript:));
        Method newMethod = class_getInstanceMethod(class, @selector(wg_objectAtIndexedSubscript:));
        if (oldMethod && newMethod) {
            method_exchangeImplementations(oldMethod, newMethod);
        }
    });
}

- (id)wg_objectAtIndexedSubscript:(NSUInteger)index{
    if (!self.count || self.count - 1 < index) {
        NSLog(@"objectAtIndexedSubscript可变数组越界");
        return nil;
    }else{
        id obj = [self wg_objectAtIndexedSubscript:index];
        return obj;
    }
}

@end

//
//  UIAlertController+HuAlert.m
//  317hu
//
//  Created by wanggang on 2018/4/4.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import "UIAlertController+HuAlert.h"

@implementation UIAlertController (HuAlert)

-(UILabel *)hu_titleLabel{
    return [self hu_viewArray:self.view][0];
}

-(UILabel *)hu_messageLabel{
    return [self hu_viewArray:self.view][1];
}

- (NSArray *)hu_viewArray:(UIView *)rootView{
    static NSArray *_subviews = nil;
    _subviews = nil;
    for (UIView *v in rootView.subviews) {
        if (_subviews) {
            break;
        }
        if ([v isKindOfClass:[UILabel class]]) {
            _subviews = rootView.subviews;
            return _subviews;
        }
        [self hu_viewArray:v];
    }
    return _subviews;
}

@end

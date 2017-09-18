//
//  MASExampleSidesView.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASExampleSidesView.h"

@implementation MASExampleSidesView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIView *lastView = self;
    for (NSInteger i = 0; i < 10; i++) {
        UIView *v = [UIView new];
        [self addSubview:v];
        v.backgroundColor = [self randomColor];
        
//        if (lastView) {
//            [v mas_makeConstraints:^(MASConstraintMaker *make){
//                make.top.left.bottom.right.equalTo(lastView).insets(UIEdgeInsetsMake(3 + i, 6 + i, 9 + i, 12 + i));
//            }];
//        }else{// 说明是第一个
//            [v mas_makeConstraints:^(MASConstraintMaker *make){
//                make.top.left.bottom.right.equalTo(self).insets(UIEdgeInsetsMake(3, 6, 9, 12));
//            }];
//
//        }
        /* lzy170918注:
         之前的每次都多了 判断是否有 lastView的情况，其实初始化时设置为self，之后每创建一个就修改一次lastView就好了。
         */
        [v mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.left.bottom.right.equalTo(lastView).insets(UIEdgeInsetsMake(3 + i, 6 + i, 9 + i, 12 + i));
        }];


        lastView  = v;
    }
    
        return self;
}

- (UIColor *)randomColor{
    
    return  [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
}

@end

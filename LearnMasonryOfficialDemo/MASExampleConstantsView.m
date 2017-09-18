//
//  MASExampleConstantsView.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASExampleConstantsView.h"

@implementation MASExampleConstantsView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIView *purpleView = [UIView new];
    purpleView.backgroundColor = [UIColor redColor];
    purpleView.layer.borderWidth = 2;
    [self addSubview:purpleView];
    
    UIView *yellowView = [UIView new];
    yellowView.backgroundColor = [UIColor yellowColor];

    yellowView.layer.borderWidth = 2;
    [self addSubview:yellowView];
    
    
    [purpleView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.left.bottom.right.equalTo(self).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.top.equalTo(@20);
        make.left.equalTo(@20);
        make.bottom.equalTo(@-20);
        make.right.equalTo(@-20);
    }];
    
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(CGPointMake(0, 50));
        make.size.equalTo(CGSizeMake(300, 100));
    }];


    /* lzy170918注:
     这个例子，只看界面和名字的话，没有明白想示范什么。
     所以直接看源码。
     是想举例 约束公式中的 constant的传入。
     
     传入 number类型，
     传入CGPoint 、 CGSize的类型。
     */
    
    return self;
}

@end

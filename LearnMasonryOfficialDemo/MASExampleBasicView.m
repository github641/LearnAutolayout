//
//  MASExampleBasicView.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASExampleBasicView.h"

@implementation MASExampleBasicView

- (id)init {
    self = [super init];
    if (!self) return nil;

    double padding = 10;
    
    UIView *redV = [UIView new];
    [self addSubview:redV];
    redV.backgroundColor = [UIColor redColor];
    redV.layer.borderColor = [UIColor blackColor].CGColor;
    redV.layer.borderWidth = 2;
    
    UIView *greenV = [UIView new];
    [self addSubview:greenV];
    greenV.backgroundColor = [UIColor greenColor];
    greenV.layer.borderColor = [UIColor blackColor].CGColor;
    greenV.layer.borderWidth = 2;
    
    UIView *blueV = [UIView new];
    [self addSubview:blueV];
    blueV.backgroundColor = [UIColor blueColor];
    blueV.layer.borderColor = [UIColor blackColor].CGColor;
    blueV.layer.borderWidth = 2;
    
    #pragma mark - ================== try1 fail ==================
//    [greenV mas_makeConstraints:^(MASConstraintMaker *make){
//        make.topMargin.equalTo(padding);
//        make.leftMargin.equalTo(padding);
//        
//    }];
//    
//    [redV mas_makeConstraints:^(MASConstraintMaker *make){
//        make.topMargin.equalTo(padding);
//        make.rightMargin.equalTo(padding);
//        make.size.mas_equalTo(greenV);
//    }];
//
//    [blueV mas_makeConstraints:^(MASConstraintMaker *make){
//        make.leftMargin.equalTo(padding);
//        make.rightMargin.equalTo(padding);
//        make.bottomMargin.equalTo(padding);
//        make.top.equalTo(redV.mas_bottom);
//    }];

#pragma mark - ================== try2 有点儿样子，但是间距不对 ==================
//
//    [greenV mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.equalTo(padding);
//        make.left.equalTo(padding);
//        
//    }];
//    
//    [redV mas_makeConstraints:^(MASConstraintMaker *make){
//        make.left.equalTo(greenV.mas_right).with.offset = padding;
//        make.top.equalTo(padding);
//        make.right.equalTo(padding);
////        make.size.mas_equalTo(greenV);
//        make.width.equalTo(greenV.mas_width);
//        make.height.equalTo(greenV.mas_height);
//        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height * 0.5);
//    }];
//    
//    [blueV mas_makeConstraints:^(MASConstraintMaker *make){
//        make.left.equalTo(padding);
//        make.right.equalTo(padding);
//        make.bottom.equalTo(padding);
//        make.top.equalTo(redV.mas_bottom);
//    }];
    #pragma mark - ================== try3 微调了 padding，以及检查padding的正负 ==================
    /* lzy170912注: 间距的正负取决于 视图要在以左上角为（0，0）的坐标系内变大还是变小

     */
    
//    [greenV mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.equalTo(padding);
//        make.left.equalTo(padding);
//
//        
//    }];
//    
//    [redV mas_makeConstraints:^(MASConstraintMaker *make){
//        make.left.equalTo(greenV.mas_right).with.offset = padding;
//        make.top.equalTo(padding);
//        make.right.equalTo(-padding);
//        make.size.mas_equalTo(greenV);// 与下面等价的。
////        make.width.equalTo(greenV.mas_width);
////        make.height.equalTo(greenV.mas_height);
////        
//        
//        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height * 0.5);
//    }];
//    
//    [blueV mas_makeConstraints:^(MASConstraintMaker *make){
//        make.left.equalTo(padding);
//        make.right.equalTo(- padding);
//        make.bottom.equalTo(- padding);
//        make.top.equalTo(redV.mas_bottom).with.offset = padding;
//    }];
//    
    
    #pragma mark - ================== origin ==================
     
    
    //if you want to use Masonry without the mas_ prefix
    //define MAS_SHORTHAND before importing Masonry.h see Masonry iOS Examples-Prefix.pch
    // 在调用masonry的时候，不写mas_的方法：在引入Masonry.h之前 定义MAN_SHORTHAND

    UIView *superView = self;
    [greenV makeConstraints:^(MASConstraintMaker *make){

        // lzy170912注：可以使用 .offset = padding ，也可以像这里一样直接链式语法。
        make.top.greaterThanOrEqualTo(superView.top).offset(padding);
        make.left.equalTo(superView.left).offset(padding);
        make.bottom.equalTo(blueV.top).offset(-padding);
        make.right.equalTo(redV.left).offset(-padding);
        make.width.equalTo(redV.width);
        
        make.height.equalTo(redV.height);
        make.height.equalTo(blueV.height);
    }];
    
    [redV mas_makeConstraints:^(MASConstraintMaker *make){
// lzy170912注：with 只是返回self，但是连接起来可读性更强一些
        make.top.equalTo(superView.mas_top).with.offset(padding);// with with
        make.left.equalTo(greenV.mas_right).offset(padding);// without with
        make.bottom.equalTo(blueV.mas_top).offset(-padding);
        make.right.equalTo(superView.mas_right).offset(-padding);
        make.height.equalTo(@[greenV, blueV]);// can pass array of views
        // lzy170912注：equalTo()圆括号内，可以传入 视图数组
    }];
    
    [blueV mas_makeConstraints:^(MASConstraintMaker *make){

        make.top.equalTo(greenV.mas_bottom).offset(padding);
        make.left.equalTo(superView.mas_left).offset(padding);
        make.bottom.equalTo(superView.mas_bottom).offset(-padding);
        make.right.equalTo(superView.mas_right).offset(-padding);
        
        make.height.equalTo(@[greenV.mas_height, redV.mas_height]);// can pass array of attributes
        // lzy170912注：equalTo()圆括号内，可以传入 视图属性的数组
    }];
    
    return self;
}

@end

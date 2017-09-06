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
    
    UIView *greenV = [UIView new];
    greenV.backgroundColor = [UIColor greenColor];
    [self addSubview:greenV];
    
    UIView *redV = [UIView new];
    redV.backgroundColor = [UIColor redColor];
    [self addSubview:redV];
    
    UIView *blueV = [UIView new];
    blueV.backgroundColor = [UIColor blueColor];
//    [self addSubview:blueV];
    
    [greenV mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.equalTo(self).with.offset = padding;
    }];

    [redV mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self).top.with.offset = padding;
        make.left.equalTo(greenV).left.with.offset = padding;
        make.right.equalTo(self).right.with.offset = -padding;
        make.size.equalTo(greenV);
    }];
    
    [blueV mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).left.with.offset = padding;
        make.right.bottom.equalTo(self).with.offset = -padding;
        
        make.top.equalTo(redV).bottom.with.offset = padding;
        
    }];


    return self;
}

@end

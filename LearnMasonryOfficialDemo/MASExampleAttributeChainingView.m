//
//  MASExampleAttributeChainingView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 31/03/14.
//  Copyright (c) 2014 Jonas Budelmann. All rights reserved.
//

#import "MASExampleAttributeChainingView.h"

@implementation MASExampleAttributeChainingView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    
    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self addSubview:greenView];
    
    UIView *redView = UIView.new;
    redView.backgroundColor = UIColor.redColor;
    redView.layer.borderColor = UIColor.blackColor.CGColor;
    redView.layer.borderWidth = 2;
    [self addSubview:redView];
    
    UIView *blueView = UIView.new;
    blueView.backgroundColor = UIColor.blueColor;
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self addSubview:blueView];
    
    
    UIView *superview = self;
    UIEdgeInsets padding = UIEdgeInsetsMake(15, 10, 15, 10);

    [greenView mas_makeConstraints:^(MASConstraintMaker *make){
        // chain attributes
        // which is the equivalent of
//        make.top.greaterThanOrEqualTo(superview).insets(padding);
//        make.left.greaterThanOrEqualTo(superview).insets(padding);
        make.top.left.equalTo(superview).insets(padding);
        make.bottom.equalTo(blueView.mas_top).insets(padding);
        make.right.equalTo(redView.mas_left).insets(padding);
        
        // 高度相等，宽度相等的都可以用同一种写法，这里使用了两种等价的写法
        make.width.equalTo(redView.mas_width);
        make.height.equalTo(@[redView, blueView]);// 与其他两个view的高度相同
        
    }];

    
    [redView mas_makeConstraints:^(MASConstraintMaker *make){
        
        // chain attributes
        make.top.right.equalTo(self).insets(padding);
        
        make.left.equalTo(greenView.mas_right).insets(padding);
        make.bottom.equalTo(blueView.mas_top).insets(padding);
        make.width.equalTo(greenView.mas_width);
        make.height.equalTo(@[ greenView, blueView]);
    }];


    [blueView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.bottom.equalTo(self).insets(padding);
        make.top.equalTo(redView.mas_bottom).insets(padding);
        
        make.height.equalTo(@[redView, greenView]);
        
    }];

    
    return self;
}

@end

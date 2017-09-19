//
//  MASExampleAspectFitView.m
//  Masonry iOS Examples
//
//  Created by Michael Koukoullis on 19/01/2015.
//  Copyright (c) 2015 Jonas Budelmann. All rights reserved.
//

#import "MASExampleAspectFitView.h"

@interface MASExampleAspectFitView ()
@property UIView *topView;
@property UIView *topInnerView;
@property UIView *bottomView;
@property UIView *bottomInnerView;
@end

@implementation MASExampleAspectFitView

// Designated initializer
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        
        /* lzy170918注:观察了一下demo界面，任务是
         两层，一层是大view，两个容器视图将屏幕分为两半；
         容器视图内有一个子视图，子视图的宽高比固定，宽或者高与父视图同；
         
         e.g.代码中，我是约束子视图的左右与父视图的左右间距为0，以此确定子视图宽 == 父视图宽，然后子视图的高与父视图的宽建立multipliedBy关系。
         
         看了下demo的实现代码：
         1、视图层级是对的，都是2容器视图，以及容器视图内有一个子视图
         2、子视图的宽高比，是自己对自己的约束，即自己的宽和自己的高建立multipliedBy关系
         3、比我多的约束：子视图的宽高 不大于 父视图的宽高；并设置子视图宽高等于 父视图的宽高的约束优先级 为priorityLow()
         
         UIView *v1 = [UIView new];
         [self addSubview:v1];
         v1.backgroundColor = [UIColor orangeColor];
         
         UIView *v2 = [UIView new];
         [v1 addSubview:v2];
         v2.backgroundColor = [UIColor cyanColor];
         
         UIView *v3 = [UIView new];
         [self addSubview:v3];
         v3.backgroundColor = [UIColor greenColor];
         
         UIView *v4 = [UIView new];
         [v3 addSubview:v4];
         v4.backgroundColor = [UIColor yellowColor];
         
         [v1 mas_makeConstraints:^(MASConstraintMaker *make){
         make.top.left.right.equalTo(self).offset(0);
         // 可以简写：make.top.left.right.equalTo(self);
         make.height.equalTo(self.height).multipliedBy(0.5);
         }];
         
         [v3 mas_makeConstraints:^(MASConstraintMaker *make){
         make.bottom.left.right.equalTo(self).offset(0);
         make.height.equalTo(self.height).multipliedBy(0.5);
         
         }];
         
         [v2 mas_makeConstraints:^(MASConstraintMaker *make){
         make.left.right.equalTo(v1).offset(0);
         make.height.equalTo(v1.width).multipliedBy(0.15);
         make.center.equalTo(v1.center);
         }];
         //
         [v4 mas_makeConstraints:^(MASConstraintMaker *make){
         make.top.bottom.equalTo(v3).offset(0);
         make.width.equalTo(v3.height).multipliedBy(0.3);
         make.center.equalTo(v3.center);
         
         }];
         */

        // Create views
        self.topView = [[UIView alloc] initWithFrame:CGRectZero];
        self.topInnerView = [[UIView alloc] initWithFrame:CGRectZero];
        self.bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        self.bottomInnerView = [[UIView alloc] initWithFrame:CGRectZero];
        
        // Set background colors
        UIColor *blueColor = [UIColor colorWithRed:0.663 green:0.796 blue:0.996 alpha:1];
        [self.topView setBackgroundColor:blueColor];
        
        UIColor *lightGreenColor = [UIColor colorWithRed:0.784 green:0.992 blue:0.851 alpha:1];
        [self.topInnerView setBackgroundColor:lightGreenColor];
        
        UIColor *pinkColor = [UIColor colorWithRed:0.992 green:0.804 blue:0.941 alpha:1];
        [self.bottomView setBackgroundColor:pinkColor];
        
        UIColor *darkGreenColor = [UIColor colorWithRed:0.443 green:0.780 blue:0.337 alpha:1];
        [self.bottomInnerView setBackgroundColor:darkGreenColor];
        
        // Layout top and bottom views to each take up half of the window
        
        [self addSubview:self.topView];
        
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.right.and.top.equalTo(self);
        }];
        
        [self addSubview:self.bottomView];
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.right.and.bottom.equalTo(self);
            make.top.equalTo(self.topView.mas_bottom);
            make.height.equalTo(self.topView);
        }];

// Inner views are configured for aspect fit with ratio of 3:1
        
        [self.topView addSubview:self.topInnerView];
        [self.topInnerView mas_makeConstraints:^(MASConstraintMaker *make){
            make.width.equalTo(self.topInnerView.mas_height).multipliedBy(3);
            make.width.and.height.lessThanOrEqualTo(self.topView);
            make.width.and.height.equalTo(self.topView).width.priorityLow();
            
            make.center.equalTo(self.topView);
        }];

        [self.bottomView addSubview:self.bottomInnerView];
        
        [self.bottomInnerView mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(self.bottomInnerView.mas_width).multipliedBy(3);
            make.width.and.height.lessThanOrEqualTo(self.bottomView);
            make.width.and.height.equalTo(self.bottomView).with.priorityLow();
            
            make.center.equalTo(self.bottomView);
        }];

        
    }
    
    return self;
}

@end

//
//  MASExampleArrayView.m
//  Masonry iOS Examples
//
//  Created by Daniel Hammond on 11/26/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleArrayView.h"

static CGFloat const kArrayExampleIncrement = 10;

@interface MASExampleArrayView ()
@property (nonatomic, strong)NSArray *btnViews;
@property (nonatomic, assign)CGFloat offset;
@end

@implementation MASExampleArrayView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:b];
    [b setTitle:@"Lower" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(lowerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:b1];
    [b1 setTitle:@"Center" forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(centerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:b2];
    [b2 setTitle:@"Raise" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(raiseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [b mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).offset(10);
    }];
    
    [b1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self);
#warning 我一直写的是center，而示例写的是 centerX
    }];
    
    [b2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.mas_right).offset(-10);
    }];

    self.btnViews = @[b,b1,b2];

    MASAttachKeys(self, b,b1,b2);
    
    return self;
}
- (void)lowerBtnAction:(UIButton *)btn{
    self.offset += kArrayExampleIncrement;
}
- (void)centerBtnAction:(UIButton *)btn{
    self.offset = 0.0;
}

- (void)raiseBtnAction:(UIButton *)btn{
    self.offset -=  kArrayExampleIncrement;
}

- (void)setOffset:(CGFloat)offset{
    
    _offset = offset;
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints{
    
    [self.btnViews updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(self.offset);
        /* lzy170925注:
         没怎么搜到 baseline的资料，它在这里可以修改为top,bottom
         */
    }];
    
    
    [super updateConstraints];
}

@end

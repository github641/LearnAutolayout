//
//  MASExampleAnimatedView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleAnimatedView.h"

@interface MASExampleAnimatedView ()
@property (nonatomic, strong)UIView *greenView;

@property (nonatomic, strong)UIView *redView;

@property (nonatomic, strong)UIView *blueView;

@property (nonatomic, assign)BOOL bigPadding;
@end

@implementation MASExampleAnimatedView

- (id)init {
    self = [super init];
    if (!self) return nil;

    self.greenView = [UIView new];
    [self addSubview:self.greenView];
    self.greenView.backgroundColor = [UIColor greenColor];
    
    self.redView = [UIView new];
    [self addSubview:self.redView];
    self.redView.backgroundColor = [UIColor redColor];
    
    self.blueView = [UIView new];
    [self addSubview:self.blueView];
    self.blueView.backgroundColor = [UIColor blueColor];
    
    MASAttachKeys(self.greenView, self.blueView, self.redView);

    self.bigPadding = NO;
    [self change];
    
    return self;
}
- (void)change{

    [self.greenView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.and.left.equalTo(self).offset(100 * self.bigPadding + 30).priorityLow();
        
    }];
    
    [self.redView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self).offset(100 * self.bigPadding + 30);
        make.right.equalTo(self).offset(-(100 * self.bigPadding + 30));
        
        make.left.equalTo(self.greenView.mas_right).offset(100 * self.bigPadding + 10);
        
        make.size.equalTo(self.greenView);// 等价与下面两句
        //        make.height.equalTo(greenView.mas_height);
        //        make.width.equalTo(greenView.mas_width);
        
        make.height.equalTo(self.redView.mas_width).multipliedBy(1.5);
    }];
    
    [self.blueView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).offset(100 * self.bigPadding + 30);
        make.right.bottom.equalTo(self).offset(-(100 * self.bigPadding + 30));
        
        make.top.lessThanOrEqualTo(self.greenView.mas_bottom).offset(100 * self.bigPadding + 10);
    }];
    
    
    
    [self setNeedsUpdateConstraints];
    
//    [self updateConstraintsIfNeeded];
    
    self.bigPadding = !self.bigPadding;
}

- (void)updateConstraints{
    
    
    
//    [self setNeedsLayout];
    
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self change];
    }];
    
    [super updateConstraints];
}

@end


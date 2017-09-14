//
//  MASExampleRemakeView.m
//  Masonry iOS Examples
//
//  Created by Sam Symons on 2014-06-22.
//  Copyright (c) 2014 Jonas Budelmann. All rights reserved.
//

#import "MASExampleRemakeView.h"

@interface MASExampleRemakeView ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, assign)BOOL up;

@end

@implementation MASExampleRemakeView

- (id)init {
    self = [super init];
    if (!self) return nil;
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.btn];
    
    [self.btn setTitle:@"Move Me!" forState:UIControlStateNormal];
    
    self.btn.layer.borderColor = [UIColor greenColor].CGColor;
    
    self.btn.layer.borderWidth = 2.0f;
    [self.btn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    MASAttachKeys(self.btn);
    
    self.up = NO;
    return self;
}


- (void)clicked{
    self.up = !self.up;
    
    [self setNeedsUpdateConstraints];
    
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:1 animations:^{
        /* lzy170914注:调用这个方法，就算在UIView的动画block中，也不会 做动画。
         - (void)setNeedsLayout;
         Description
         Invalidates the current layout of the receiver and triggers a layout update during the next update cycle.
         Call this method on your application’s main thread when you want to adjust the layout of a view’s subviews. This method makes a note of the request and returns immediately. 
         Because this method does not force an immediate update, but instead waits for the next update cycle, you can use it to invalidate the layout of multiple views before any of those views are updated. This behavior allows you to consolidate all of your layout updates to one update cycle, which is usually better for performance.
         Availability	iOS (2.0 and later), tvOS (9.0 and later)
         */
//        [self setNeedsLayout];
        
        /* lzy170914注:
         Lays out the subviews immediately.
         Use this method to force the layout of subviews before drawing. Using the view that receives the message as the root view, this method lays out the view subtree starting at the root.
         Availability	iOS (2.0 and later), tvOS (9.0 and later)
         */
        [self layoutIfNeeded];
        /* lzy170914注:
         认真理解了 上一个update Constrains例子，做得很好，只是这里调用了不合适的API，导致view移动没有动画。
         */
    }];
    
}
+ (BOOL)requiresConstraintBasedLayout{
    return YES;
}

- (void)updateConstraints{
    
    
    UIView *superView = self;
    double padding = 10;
    
    
    [self.btn mas_remakeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(100));
        make.height.equalTo(@(100));
        if (self.up) {
            make.right.equalTo(superView.right).offset(-padding);
            make.bottom.equalTo(superView.bottom).offset(-padding);
        }else{
            make.top.equalTo(superView.top).offset(padding);
            make.left.equalTo(superView.left).offset(padding);
        }
        

    }];
    
    [super updateConstraints];
}

@end

//
//  MASExampleUpdateView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 3/11/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//
/* lzy170914注:
 整理：
 首先，本类是自定义的view。
 相对于base那个案例所有的约束在init方法中写好。
 这个例子中的init方法没有对界面进行任何的布局。所有的布局约束都是写在-updateConstraints中的。
 
 为了让视图渲染时，基于约束布局，那么需要
 先实现：+ requiresConstraintBasedLayout，并返回YES
 
 在点击方法中，每次修改btnSize的宽和高
 并调用需要更新约束的
 
 立即更新约束
 
 之后将[self layoutIfNeeded];方法，写到UIView的animation中。
 
系统自然会去调用-updateConstraints方法。
 */

#import "MASExampleUpdateView.h"

@interface MASExampleUpdateView ()
@property (nonatomic, strong)UIButton *btn;

// lzy170913注：try 1
@property (nonatomic, assign)int clickTime;
#define w 100
#define h w
#define times  8

// lzy170913注：original
@property (nonatomic, assign)CGSize btnSize;
@end

@implementation MASExampleUpdateView

- (id)init {
    self = [super init];
    if (!self) return nil;

    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.btn];
    
    [self.btn setTitle:@"Grow Me!" forState:UIControlStateNormal];
    
    self.btn.layer.borderColor = [UIColor greenColor].CGColor;
    
    self.btn.layer.borderWidth = 2.0f;
    [self.btn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
// lzy170913注：try1 try2
//    UIView *superView = self;
////
//    [self.btn mas_makeConstraints:^(MASConstraintMaker *make){
//        make.center.equalTo(superView);
//        make.size.equalTo(CGSizeMake(w, h));
//        
//    }];
    

    // masonry重写了constriant的-description方法，让log更易懂了
    MASAttachKeys(self.btn);
    
    self.btnSize = CGSizeMake(100, 100);
    
    return self;
}

- (void)clicked{
    
    // lzy170913注：try 1 每次触碰到边界的时候，都会有log说打破了 约束。应该要设置约束优先级，但是没有成功。我应该让 边界值判断的优先级 高于 空间宽高的优先级。但是改为999或者250，点击就不动了
//    self.clickTime++;
//    [self.btn mas_updateConstraints:^(MASConstraintMaker *make){
//                make.size.equalTo(CGSizeMake(w + times * self.clickTime, h + times * self.clickTime)).priority(250);
//        make.left.greaterThanOrEqualTo(self.left);
//        make.right.lessThanOrEqualTo(self.right);
//        make.top.greaterThanOrEqualTo(self.top);
//        make.bottom.lessThanOrEqualTo(self.bottom);
//
////        .priority(999)
//    }];

    // lzy170913注：try 2
//    self.clickTime++;
//    [self.btn mas_updateConstraints:^(MASConstraintMaker *make){
//        make.size.equalTo(CGSizeMake(w + times * self.clickTime, h + times * self.clickTime)).priorityLow();
////        make.center.equalTo(self.center);
//        
//        make.width.lessThanOrEqualTo(self.width).priorityHigh();
//        make.height.lessThanOrEqualTo(self.height).priorityHigh();
//        
//        
//    }];
    
    
    // lzy170913注：original
    self.btnSize = CGSizeMake(self.btnSize.width * 1.3, self.btnSize.height * 1.3);
    
    
    /* lzy170913注:
     
     - (void)setNeedsUpdateConstraints;
     
     Description
     
     Controls whether the view’s constraints need updating.
     When a property of your custom view changes in a way that would impact（影响，冲击；挤压） constraints, you can call this method to indicate that the constraints need to be updated at some point in the future. 
     
     The system will then call updateConstraints as part of its normal layout pass. 
     
     Use this as an optimization tool to batch constraint changes. Updating constraints all at once just before they are needed ensures that you don’t needlessly（不必要的） recalculate constraints when multiple changes are made to your view in between layout passes.
     
     Availability	iOS (6.0 and later), tvOS (6.0 and later)
     */
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    
    /* lzy170914注:
     Updates the constraints for the receiving view and its subviews.
     Whenever a new layout pass is triggered for a view, 
     
     the system invokes this method to ensure that any constraints for the view and its subviews are updated with information from the current view hierarchy and its constraints. 
     
     This method is called automatically by the system, but may be invoked manually if you need to examine the most up to date constraints.
     
     Subclasses should not override this method.
     
     Availability	iOS (6.0 and later), tvOS (6.0 and later)
     */
     // update the constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        /* lzy170914注:
         Lays out the subviews immediately.
         Use this method to force the layout of subviews before drawing.
         Using the view that receives the message as the root view, this method lays out the view subtree starting at the root.
         Availability	iOS (2.0 and later), tvOS (9.0 and later)
         */
        [self layoutIfNeeded];
    }];
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints{
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(self);
        make.width.equalTo(@(self.btnSize.width)).priorityLow();
        make.height.equalTo(@(self.btnSize.height)).priorityLow();
        
        make.width.lessThanOrEqualTo(self);
        make.height.lessThanOrEqualTo(self);
    }];

    
    
    // according to apple super should be called at end of method
    [super updateConstraints];
}
/* lzy170914注:
 初始化方法是没有任何的布局代码的。所有的布局约束都在 -updateConstraints方法中。
 
 只有上面的代码，没有这一句，界面上是没有任何东西的。
 
 A Boolean value that indicates whether the receiver depends on the constraint-based layout system.
 Custom views should override this to return YES if they cannot layout correctly using autoresizing.
 Returns
 YES if the view must be in a window using constraint-based layout to function properly, NO otherwise.
 Availability	iOS (6.0 and later), tvOS (6.0 and later)
 
 */
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end

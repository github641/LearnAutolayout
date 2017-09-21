//
//  MASExampleAnimatedView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

/* lzy170920注:一次尝试，相似，但是做得很差，比原动画差远了
 
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
 
 make.left.equalTo(self.greenView.mas_right).offset(100 * self.bigPadding + 30);
 
 make.size.equalTo(self.greenView);// 等价与下面两句
 //        make.height.equalTo(greenView.mas_height);
 //        make.width.equalTo(greenView.mas_width);
 
 make.height.equalTo(self.redView.mas_width).multipliedBy(1.5);
 }];
 
 [self.blueView mas_remakeConstraints:^(MASConstraintMaker *make){
 make.left.equalTo(self).offset(100 * self.bigPadding + 30);
 make.right.bottom.equalTo(self).offset(-(100 * self.bigPadding + 30));
 
 make.top.equalTo(self.greenView.mas_bottom).offset(100 * self.bigPadding + 30);
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
 

 */

#import "MASExampleAnimatedView.h"

@interface MASExampleAnimatedView ()
@property (nonatomic, strong)NSMutableArray *animatableConstraints;
@property (nonatomic, assign)int padding;
@property (nonatomic, assign)BOOL animating;
@end

@implementation MASExampleAnimatedView

- (id)init {
    self = [super init];
    if (!self) return nil;

    
    
    /* lzy170920注:
     这个UIView.new之前可能没有见过。好神奇。
     这个例子中，好多都是 点语法 点出来的。有点儿Masonry链式编程的特色。
     但是缺点是 没有代码补全提示。
     */
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
    int padding = self.padding = 10;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);
    
    self.animatableConstraints = NSMutableArray.new;
    
    /* lzy170920注:
     思路：

     1、统一一个padding，这个很重要，我写的时候，就有的是10，有的是30
     2、
     ①、数组装 视图的 edges约束（相对于父视图、优先级低，三个视图都有）
     make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),这个约束住了横屏和竖屏的。而我自己写的，在横屏时并不可用
     ②、与兄弟视图的关系的约束，将来遍历改变
     3、让red green视图等宽等高，两两与 blue高相等
     
     让 数组中的约束的 constraint.insets 不断在 由10 组成的Insets和 100组成的Insets两个值之间变化。
     
     一个疑问，是否数组中所有的约束都有insets属性呢？？？
     验证：数组中有6个约束insets，看头文件，它是block类型
     打印看下：都有打印，对象只有两个，奇怪
     <__NSMallocBlock__: 0x60800024bca0>time:1
     <__NSMallocBlock__: 0x6000002437b0>time:2
     <__NSMallocBlock__: 0x60800024bca0>time:3
     <__NSMallocBlock__: 0x60800024bca0>time:4
     <__NSMallocBlock__: 0x6000002437b0>time:5
     <__NSMallocBlock__: 0x6000002437b0>time:6
     
     比如把redView的这条约束放到数组外面：
     make.bottom.equalTo(blueView.mas_top).offset(-padding),
那么遍历的时候，就是5条，且红蓝视图间距不再发生变化。
     TODO: #待完成#
     也就是说，这条约束创建时，使用的是offset。
     但是遍历的时候，改变了这条约束的 insets,即对应改变了这条约束的offset，那么offset是啥呢，他们之间的关系是怎么样的？？？
     
     */
    
    
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make){
        [self.animatableConstraints addObjectsFromArray:@[
         make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
         make.bottom.equalTo(blueView.mas_top).offset(-padding)
         ]];
        
        make.size.equalTo(redView);
        make.height.equalTo(blueView.mas_height);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make){
        [self.animatableConstraints addObjectsFromArray:@[
          make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
          make.left.equalTo(greenView.mas_right).offset(padding),
          make.bottom.equalTo(blueView.mas_top).offset(-padding),
          ]];
        make.size.equalTo(greenView);
        make.height.equalTo(blueView.mas_height);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make){
        [self.animatableConstraints addObjectsFromArray:@[
              make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
          ]];
        
        make.height.equalTo(greenView.mas_height);
        make.height.equalTo(redView.mas_height);
    }];



    
    return self;
}

- (void)animateWithInvertedInsets:(BOOL)invertedInsets {
    if (!self.animating) return;
    int padding = invertedInsets ? 100 : self.padding;
    
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    
    NSInteger time = 0;
    
    for (MASConstraint *constraint in self.animatableConstraints){
        NSLog(@"%@time:%ld", constraint.insets, ++time);
        
        constraint.insets = paddingInsets;
    }
    
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        // repeat!
        [self animateWithInvertedInsets:!invertedInsets];
    }];
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    self.animating = newWindow != nil;
}
- (void)didMoveToWindow{
    [self layoutIfNeeded];
    
    if (self.window) {
        self.animating = YES;
        [self animateWithInvertedInsets:NO];
    }
}



@end


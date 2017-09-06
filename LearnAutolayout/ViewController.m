//
//  ViewController.m
//  LearnAutolayout
//
//  Created by alldk on 2017/8/23.
//  Copyright © 2017年 alldk. All rights reserved.
//
/* lzy170906注:
 
 */

#import "ViewController.h"

#import <Masonry/Masonry.h>
#import <MMPlaceHolder/MMPlaceHolder.h>

#import "UIView+Mansonry_LJC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test1];
    [self test2];
//    [self test3];
    
//    [self test4];
    
    #pragma mark - ================== 官方demo ==================
    
}

- (void)test4{
    UIView *sv = [UIView new];
    [sv showPlaceHolder];
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    UIView *sv11 = [UIView new];
    UIView *sv12 = [UIView new];
    UIView *sv13 = [UIView new];
    UIView *sv21 = [UIView new];
    UIView *sv31 = [UIView new];
    sv11.backgroundColor = [UIColor redColor];
    sv12.backgroundColor = [UIColor redColor];
    sv13.backgroundColor = [UIColor redColor];
    sv21.backgroundColor = [UIColor redColor];
    sv31.backgroundColor = [UIColor redColor];
    [sv addSubview:sv11];
    [sv addSubview:sv12];
    [sv addSubview:sv13];
    [sv addSubview:sv21];
    [sv addSubview:sv31];
    
    //给予不同的大小 测试效果
    [sv11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@[sv12,sv13]);
        make.centerX.equalTo(@[sv21,sv31]);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [sv12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    [sv13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [sv21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    [sv31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 33.3));
    }];
    [sv distributeSpacingHorizontallyWith:@[sv11,sv12,sv13]];
    [sv distributeSpacingVerticallyWith:@[sv11,sv21,sv31]];
    [sv showPlaceHolderWithAllSubviews];
    [sv hidePlaceHolder];
    
    
}

- (void)test3{
    UIView *sv = [UIView new];
    [sv showPlaceHolder];
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    UIScrollView *scrollView = [UIScrollView new];
    [sv addSubview:scrollView];
    [scrollView showPlaceHolder];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(6, 6, 6, 6));
    }];
    
    UIView *container  = [UIView new];
    [scrollView addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    int count = 10;
    UIView *lastView = nil;
    
    for (NSInteger i = 0; i < count; ++i) {
        UIView *subV = [UIView new];
        [container addSubview:subV];
        
        subV.backgroundColor = [UIColor colorWithHue:(arc4random() % 256 / 256.0) saturation:(arc4random() % 256 / 256.0) + 0.5 brightness:(arc4random() % 256 / 256.0) + 0.5 alpha:1];
        
        [subV mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.left.and.right.equalTo(container);
            make.height.mas_equalTo(@(20 * i));
            
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            }else{
                make.top.mas_equalTo(container.mas_top);
            }
            
        }];
        
        lastView = subV;
        [lastView showPlaceHolder];

    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

/* lzy170906注:
 http://www.cnblogs.com/HypeCheng/articles/4177558.html
 */
- (void)test2{
    UIView *sv = [UIView new];
    [sv showPlaceHolder];
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    
    UIView *sv1 = [UIView new];
    [sv addSubview:sv1];
    [sv1 showPlaceHolder];
    sv1.backgroundColor = [UIColor purpleColor];
    
    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        // lzy170906注：等价的写法；不要同时写多句，会造成意想不到的效果
//        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
//        make.top.left.bottom.right.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
//        make.edges.equalTo(sv).insets(UIEdgeInsetsMake(1, 1, 1, 1));
        
//        make.top.equalTo(sv).with.offset(10);
//        make.left.equalTo(sv).with.offset(10);
//        make.bottom.equalTo(sv).with.offset(-10);
//        make.right.equalTo(sv).with.offset(-10);


    }];
    
    int padding1 = 10;
    
//    UIView *sv2 = [UIView new];
//    [sv addSubview:sv2];
//    [sv2 showPlaceHolder];
//    sv2.backgroundColor = [UIColor lightGrayColor];
//    
//    
//    
//    UIView *sv3 = [UIView new];
//    [sv addSubview:sv3];
//    [sv3 showPlaceHolder];
//    sv3.backgroundColor = [UIColor lightGrayColor];
//    
//    [sv2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(sv.mas_centerY);
//        make.left.equalTo(sv.mas_left).with.offset(padding1);
//        make.right.equalTo(sv3.mas_left).with.offset(-padding1);
//        make.height.mas_equalTo(@150);
//        make.width.equalTo(sv3);
//    }];
//    
//    [sv3 mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.centerY.mas_equalTo(sv.mas_centerY);
//        make.left.equalTo(sv2.mas_right).with.offset(padding1);
//        make.right.equalTo(sv.mas_right).with.offset(-padding1);
//        make.height.mas_equalTo(@150);
//        make.width.equalTo(sv2);
//        
//    }];
}


/* lzy170906注:
iOS中，会将view的布局定义为一系列的线性方程式，存放在UIView的属性中，在view布局的而时候，通过这饿方程式，计算出每一个view的frame来完成布局。这就是autolayout。
 autolayout将所有的而方程式用constraint表示，存放在view的属性constraints下。
 @property (nonatomic, readonly)NSArray<__kindof NSLayoutConstraint *> *constraints NS_AVAILABLE_IOS(6_0)
 每一个constraint，表示一个相等或不相等（大于、小于）关系。
 文章http://www.jianshu.com/p/052e8c7e8e7f
 
 */
- (void)test1{
    
    UILabel *label1 = [UILabel new];
    label1.text = @"你";
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(100));
    }];


    
    
    UILabel *label2 = [UILabel new];
    label2.text = @"你妈喊你回家吃饭辣阿凡达嘀嗒嘀嗒嘀嗒";
    [self.view addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(300));
    }];
    
    
    [@[label1,label2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100).priority(500);
        
    }];
    label1.backgroundColor = [UIColor purpleColor];
    label2.backgroundColor = [UIColor grayColor];


    /* lzy170906注:

     1. Label1，显示几个文字，明显足够，它的IntrinsicContentSize宽度比100px小，所以当添加一个宽度为100px的约束时，ContentHugging在起作用。ContentHugging的优先级为250。宽度为100px的约束，优先级为500，大于ContentHugging。所以宽度为100px.
     2. Label2，显示几个文字需要的长度较大，它的IntrinsicContentSize宽度比100px大。所以当添加一个宽度为100px的约束时，CompressionResistance在起作用，CompressionResistance的优先级为750。宽度为100px的约束，优先级为500，小于CompressionResistance。所以宽度还是IntrinsicContentSize的宽度。
     根据这个例子，大家应该能明白ContentHugging和CompressionResistance是什么意思了吧。
     
     这里留个问题给大家，如果设置的不是宽度为100，而是Label1宽度等于Label2宽度，那么会出现什么情况？是都变成Label1的宽度了，还是都变成Label2的宽度了？还是不变？
     make.width.mas_equalTo(label1.mas_width);

     */
    
    // 在使用了约束之后。手动设置frame是不起作用的
    /* lzy注170824
     
     在Autolayout下使用Frame在Autolayout下使用Frame分为2中情况
     1. Autolayout生效之前使用frame。这种情况比较常见，比如在viewDidLoad中对一个view添加了约束，之后又通过Frame调整他的位置。
     这种情况下，通过Frame调整位置的代码是无效的。因为在真正布局显示到频幕上的时候，系统会根据约束，重新计算Frame，之前设置的Frame会被冲掉
     2. Autolayout生效之后，使用frame。这种情况稍微少一些，比如View之前就设置了约束，点击某个按钮，需要改变View的Frame。这时候不使用约束，直接setFrame：
     这种情况下，setFrame：是可以生效的，不过由于是直接setFrame，不是根据约束计算的。所以他的子View，父View，以及同级的约束依赖的View，都不会跟着改变。而且如果他的superView被触发了layoutSubviews，又会自动根据约束设置成约束的Frame，后患无穷。所以一个View使用约束之后，强烈建议不要再对他使用frame。
     第二种情况下，如果是需要做一个动画，动画结束后，又会恢复到原有位置。可以使用Frame
     
     */
    label1.frame = CGRectMake(0, 0, 10, 10);
}





@end

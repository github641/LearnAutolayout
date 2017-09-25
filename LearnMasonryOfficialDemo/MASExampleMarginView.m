//
//  MASExampleMarginView.m
//  Masonry iOS Examples
//
//  Created by Craig Siemens on 2015-02-23.
//  Copyright (c) 2015 Jonas Budelmann. All rights reserved.
//

#import "MASExampleMarginView.h"

@implementation MASExampleMarginView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIView *lastView = self;
    for (NSInteger i = 0; i < 10; i++) {
        UIView *v = [UIView new];
        [self addSubview:v];
        v.backgroundColor = [self randomColor];
        
        
        UIEdgeInsets inset = UIEdgeInsetsMake(3 , 6 , 9, 12 );
        
        //        if (lastView) {
        //            [v mas_makeConstraints:^(MASConstraintMaker *make){
        //                make.top.left.bottom.right.equalTo(lastView).insets(UIEdgeInsetsMake(3 + i, 6 + i, 9 + i, 12 + i));
        //            }];
        //        }else{// 说明是第一个
        //            [v mas_makeConstraints:^(MASConstraintMaker *make){
        //                make.top.left.bottom.right.equalTo(self).insets(UIEdgeInsetsMake(3, 6, 9, 12));
        //            }];
        //
        //        }
        /* lzy170918注:
         之前的每次都多了 判断是否有 lastView的情况，其实初始化时设置为self，之后每创建一个就修改一次lastView就好了。
         */
        [v mas_makeConstraints:^(MASConstraintMaker *make){
//            make.top.left.bottom.right.equalTo(lastView).insets(UIEdgeInsetsMake(3 + i, 6 + i, 9 + i, 12 + i));
//            make.topMargin.leftMargin.bottomMargin.rightMargin.equalTo(lastView).insets(UIEdgeInsetsMake(3 , 6 , 9, 12 ));
//            make.topMargin.leftMargin.bottomMargin.rightMargin.equalTo(lastView).offset(10);
            /* lzy170925注:不是想要的效果
             以上三种方式，Masonry都无法解析
             
             这个也无法解析：
             make.topMargin.equalTo(lastView.topMargin);
             make.leftMargin.equalTo(lastView.leftMargin);
             make.bottomMargin.equalTo(lastView.bottomMargin);
             make.rightMargin.equalTo(lastView.rightMargin);
             */
        

            
            make.top.equalTo(lastView.topMargin);
            make.left.equalTo(lastView.leftMargin);
            make.bottom.equalTo(lastView.bottomMargin);
            make.right.equalTo(lastView.rightMargin);
        }];
        
        
        lastView  = v;
    }
    
    return self;
}

- (UIColor *)randomColor{
    
    return  [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
}

@end

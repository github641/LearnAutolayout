//
//  MASExampleDistributeView.m
//  Masonry iOS Examples
//
//  Created by bibibi on 15/8/6.
//  Copyright (c) 2015年 Jonas Budelmann. All rights reserved.
//

#import "MASExampleDistributeView.h"

@implementation MASExampleDistributeView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    return self;
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end

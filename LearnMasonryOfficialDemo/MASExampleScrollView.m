//
//  MASExampleScrollView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 20/11/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleScrollView.h"

/**
 *  UIScrollView and Auto Layout don't play very nicely together see
 *  https://developer.apple.com/library/ios/technotes/tn2154/_index.html
 *
 *  This is an example of one workaround
 *
 *  for another approach see https://github.com/bizz84/MVScrollViewAutoLayout
 */

@interface MASExampleScrollView ()

@end

@implementation MASExampleScrollView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    return self;
}

@end

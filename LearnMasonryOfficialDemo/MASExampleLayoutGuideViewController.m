//
//  MASExampleLayoutGuideViewController.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 26/11/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleLayoutGuideViewController.h"

@interface MASExampleLayoutGuideViewController ()

@end

@implementation MASExampleLayoutGuideViewController

- (id)init {
    self = [super init];
    if (!self) return nil;

    self.title = @"Layout Guides";

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}

@end

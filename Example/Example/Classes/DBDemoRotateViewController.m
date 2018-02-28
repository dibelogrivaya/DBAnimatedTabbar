//
//  DBDemoRotateViewController.m
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBDemoRotateViewController.h"

#import "DBAnimatedTabbarItem.h"
#import "DBRotateAnimation.h"

@implementation DBDemoRotateViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [(DBAnimatedTabbarItem *)self.tabBarItem setAnimation:[DBRotateAnimation animationWithRotateAnimationDirection:DBRotateAnimationDirectionRight]];
    }
    return self;
}

@end


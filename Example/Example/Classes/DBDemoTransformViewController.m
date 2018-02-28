//
//  DBDemoTransformViewController.m
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBDemoTransformViewController.h"

#import "DBAnimatedTabbarItem.h"
#import "DBTransformAnimation.h"

@implementation DBDemoTransformViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [(DBAnimatedTabbarItem *)self.tabBarItem setAnimation:[DBTransformAnimation animationWithFlipAnimationMode:DBTransformAnimationModeFlipHorizontal]];
    }
    return self;
}

@end

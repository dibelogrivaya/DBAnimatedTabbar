//
//  DBDemoBounceViewController.m
//  Example
//
//  Created by Diana Belogrivaya on 2/25/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBDemoBounceViewController.h"

#import "DBAnimatedTabbarItem.h"
#import "DBBounceAnimation.h"

@implementation DBDemoBounceViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [(DBAnimatedTabbarItem *)self.tabBarItem setAnimation:[DBBounceAnimation new]];
    }
    return self;
}

@end

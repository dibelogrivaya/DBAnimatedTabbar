//
//  DBDemoTabbarController.m
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBDemoTabbarController.h"

@interface DBDemoTabbarController ()

@end

@implementation DBDemoTabbarController

+ (NSString *)tabbarItemTitleAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return @"Normal";
        case 1: return @"Bounce";
        case 2: return @"Frame";
        case 3: return @"Transform";
        case 4: return @"Rotate";
        default: return nil;
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self changeAnimatedTabbarItemsSelectedColor:[UIColor purpleColor]
                                     unselectedColor:[UIColor grayColor]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.title = [[self class] tabbarItemTitleAtIndex:idx];
    }];
}

@end

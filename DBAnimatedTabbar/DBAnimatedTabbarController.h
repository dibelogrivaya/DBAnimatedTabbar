//
//  DBAnimatedTabbarController.h
//  Example
//
//  Created by Diana Belogrivaya on 2/25/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBAnimatedTabbarController : UITabBarController

- (void)changeAnimatedTabbarVisibility:(BOOL)isVisible;
- (void)changeAnimatedTabbarItemsSelectedColor:(UIColor *)selectedColor
                               unselectedColor:(UIColor *)unselectedColor;

@end

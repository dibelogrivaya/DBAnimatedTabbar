//
//  DBAnimatedTabbarItem.h
//  Example
//
//  Created by Diana Belogrivaya on 2/25/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBBadge;
@class DBTabbarItemAnimation;

@interface DBAnimatedTabbarItem : UITabBarItem

@property (strong, nonatomic, readonly) UILabel *itemLabel;
@property (strong, nonatomic, readonly) UIImageView *itemIcon;

@property (strong, nonatomic) DBBadge *badge;
@property (strong, nonatomic) DBTabbarItemAnimation *animation;

@property (strong, nonatomic) UIFont *itemLabelFont;
@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) UIColor *unselectedColor;
@property (strong, nonatomic) UIColor *containerSelectedColor;
@property (strong, nonatomic) UIColor *containerUnselectedColor;

@property (assign, nonatomic) CGFloat yOffSet;

- (void)addItemOnView:(UIView *)view
             maxWidth:(CGFloat)maxWidth;

- (void)selectAnimated:(BOOL)animated;
- (void)deselect;

@end


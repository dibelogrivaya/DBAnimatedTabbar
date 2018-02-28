//
//  DBTabbarItemAnimation.m
//  Example
//
//  Created by Diana Belogrivaya on 2/27/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBTabbarItemAnimation.h"

@implementation DBTabbarItemAnimation

- (instancetype)init {
    if (self = [super init]) {
        _animationDuration = .44f;
    }
    return self;
}

- (void)updateIcon:(UIImageView *)icon label:(UILabel *)label withColor:(UIColor *)color {
    BOOL isTransparentColor = [color isEqual:[UIColor clearColor]];
    
    label.textColor = color;
    
    if (icon.image != nil) {
        UIImageRenderingMode renderMode = isTransparentColor ? UIImageRenderingModeAlwaysOriginal : UIImageRenderingModeAlwaysTemplate;
        UIImage *renderImage = [icon.image imageWithRenderingMode:renderMode];
        icon.image = renderImage;
        icon.tintColor = color;
    }
}

- (void)selectItemWithIcon:(UIImageView *)icon label:(UILabel *)label selectedColor:(UIColor *)selectedColor {
    [self updateIcon:icon label:label withColor:selectedColor];
}

- (void)deselectItemWithIcon:(UIImageView *)icon label:(UILabel *)label unselectedColor:(UIColor *)unselectedColor {
    [self updateIcon:icon label:label withColor:unselectedColor];
}

- (void)animateSelectItemWithIcon:(UIImageView *)icon label:(UILabel *)label selectedColor:(UIColor *)selectedColor {
    [self selectItemWithIcon:icon label:label selectedColor:selectedColor];
}

@end

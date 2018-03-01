//
//  DBAnimatedTabbarItem.m
//  Example
//
//  Created by Diana Belogrivaya on 2/25/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBAnimatedTabbarItem.h"

#import "DBTabbarItemAnimation.h"
#import "DBBadge.h"

@implementation DBAnimatedTabbarItem

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupItem];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupItem];
    }
    return self;
}

- (void)setupItem {
    self.selectedColor = [UIColor blueColor];
    self.unselectedColor = [UIColor blackColor];
    self.itemLabelFont = [UIFont systemFontOfSize:11.f];
    self.containerSelectedColor = [UIColor clearColor];
    self.containerUnselectedColor = [UIColor clearColor];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    self.itemIcon.alpha = enabled ? 1 : .5f;
    self.itemLabel.alpha = enabled ? 1 : .5f;
}

- (void)setTitle:(NSString *)title {
    if (self.itemLabel != nil) {
        [super setTitle:nil];
        self.itemLabel.text = title;
    } else {
        [super setTitle:title];
    }
}

- (void)setImage:(UIImage *)image {
    if (self.itemIcon != nil) {
        [super setImage:nil];
        self.itemIcon.image = image;
    } else {
        [super setImage:image];
    }
}

- (DBTabbarItemAnimation *)currentAnimation {
    if (self.animation == nil) {
        self.animation = [DBTabbarItemAnimation new];
    }
    return self.animation;
}

- (void)addItemOnContainer:(UIView *)container {
    UIImageRenderingMode renderMode = [self.unselectedColor isEqual:[UIColor clearColor]] ? UIImageRenderingModeAlwaysOriginal : UIImageRenderingModeAlwaysTemplate;
    UIImage *iconImage = self.image ?: self.itemIcon.image;
    UIImageView *icon = [[UIImageView alloc] initWithImage:iconImage ? [iconImage imageWithRenderingMode:renderMode] : nil];
    icon.translatesAutoresizingMaskIntoConstraints = NO;
    icon.tintColor = self.unselectedColor;
    icon.highlightedImage = self.selectedImage ? [self.selectedImage imageWithRenderingMode:renderMode] : nil;
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.alpha = self.enabled ? 1.f : .5f;
    [container addSubview:icon];
    
    UILabel *textLabel = [UILabel new];
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    textLabel.text = (self.title == nil || self.title.length == 0) ? self.itemLabel.text : self.title;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = self.unselectedColor;
    textLabel.font = self.itemLabelFont;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 1;
    textLabel.alpha = self.enabled ? 1.f : .5f;
    [container addSubview:textLabel];
    
    [container addConstraint:[NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:icon attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[textLabel]-5-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(textLabel)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=5)-[icon]-(>=5)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(icon)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[icon]-5-[textLabel]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(icon, textLabel)]];
    [textLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    self.image = nil;
    self.title = nil;
    
    _itemLabel = textLabel;
    _itemIcon = icon;
}

- (void)deselect {
    [[self currentAnimation] deselectItemWithIcon:self.itemIcon label:self.itemLabel unselectedColor:self.unselectedColor];
}

- (void)selectAnimated:(BOOL)animated {
    if (animated) {
        [[self currentAnimation] animateSelectItemWithIcon:self.itemIcon label:self.itemLabel selectedColor:self.selectedColor];
    } else {
        [[self currentAnimation] selectItemWithIcon:self.itemIcon label:self.itemLabel selectedColor:self.selectedColor];
    }
}

@end



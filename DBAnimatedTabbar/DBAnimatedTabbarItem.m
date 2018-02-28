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
    self.yOffSet = .0f;
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

- (void)addItemOnView:(UIView *)view maxWidth:(CGFloat)maxWidth {
    UIImageRenderingMode renderMode = [self.unselectedColor isEqual:[UIColor clearColor]] ? UIImageRenderingModeAlwaysOriginal : UIImageRenderingModeAlwaysTemplate;
    UIImage *iconImage = self.image ?: self.itemIcon.image;
    UIImageView *icon = [[UIImageView alloc] initWithImage:iconImage ? [iconImage imageWithRenderingMode:renderMode] : nil];
    icon.translatesAutoresizingMaskIntoConstraints = NO;
    icon.tintColor = self.unselectedColor;
    icon.highlightedImage = self.selectedImage ? [self.selectedImage imageWithRenderingMode:renderMode] : nil;
    icon.alpha = self.enabled ? 1.f : .5f;
    [view addSubview:icon];
    
    CGSize itemSize = CGSizeEqualToSize(self.image.size, CGSizeZero) ? CGSizeZero : CGSizeMake(30, 30);
    [self createConstraintsForView:icon container:view size:itemSize yOffset:-5 - self.yOffSet];
    
    UILabel *textLabel = [UILabel new];
    textLabel.text = (self.title == nil || self.title.length == 0) ? self.itemLabel.text : self.title;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = self.unselectedColor;
    textLabel.font = self.itemLabelFont;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    textLabel.alpha = self.enabled ? 1.f : .5f;
    [view addSubview:textLabel];
    
    [self createConstraintsForView:textLabel container:view width:maxWidth height:0 yOffset:16 - self.yOffSet];
    
    self.image = nil;
    self.title = nil;
    
    _itemLabel = textLabel;
    _itemIcon = icon;
}

- (void)createConstraintsForView:(UIView *)view container:(UIView *)container size:(CGSize)size yOffset:(CGFloat)yOffset {
    [self createConstraintsForView:view container:container width:size.width height:size.height yOffset:yOffset];
}

- (void)createConstraintsForView:(UIView *)view container:(UIView *)container width:(CGFloat)width height:(CGFloat)height yOffset:(CGFloat)yOffset {
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:container
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:container
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:yOffset]];
    
    if (width > CGFLOAT_MIN) {
        [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1
                                                          constant:width]];
    }
    
    if (height > CGFLOAT_MIN) {
        [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1
                                                          constant:height]];
    }
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



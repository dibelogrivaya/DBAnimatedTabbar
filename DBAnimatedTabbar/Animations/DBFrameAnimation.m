//
//  DBFrameAnimation.m
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBFrameAnimation.h"

@import QuartzCore;

static NSString *const kDBAnimationKeyFrame = @"contents";

@interface DBFrameAnimation ()

@property (strong, nonatomic) NSArray <UIImage *> *animationImages;
@property (strong, nonatomic) UIImage *selectedImage;

@end

@implementation DBFrameAnimation

+ (instancetype)animationWithImages:(NSArray<UIImage *> *)images {
    return [[[self class] alloc] initWithImages:images];
}

- (instancetype)initWithImages:(NSArray<UIImage *> *)images {
    if (self = [super init]) {
        _animationImages = images;
        _selectedImage = [images lastObject];
    }
    return self;
}

- (void)animateSelectItemWithIcon:(UIImageView *)icon label:(UILabel *)label selectedColor:(UIColor *)selectedColor {
    if (self.animationImages.count == 0) {
        [super animateSelectItemWithIcon:icon label:label selectedColor:selectedColor];
        return;
    }
    
    icon.tintColor = selectedColor;
    label.textColor = selectedColor;
    
    [self animateImagesInIcon:icon];
}

- (void)selectItemWithIcon:(UIImageView *)icon label:(UILabel *)label selectedColor:(UIColor *)selectedColor {
    if (self.animationImages.count == 0) {
        [super selectItemWithIcon:icon label:label selectedColor:selectedColor];
        return;
    }
    
    icon.tintColor = selectedColor;
    label.textColor = selectedColor;
    icon.image = self.selectedImage;
}

- (void)deselectItemWithIcon:(UIImageView *)icon label:(UILabel *)label unselectedColor:(UIColor *)unselectedColor {
    if (self.animationImages.count == 0) {
        [super deselectItemWithIcon:icon label:label unselectedColor:unselectedColor];
        return;
    }
    
    icon.tintColor = unselectedColor;
    label.textColor = unselectedColor;
}

- (void)animateImagesInIcon:(UIImageView *)icon {
    __block NSMutableArray *images = [NSMutableArray arrayWithCapacity:self.animationImages.count];
    [self.animationImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [images addObject:(id)obj.CGImage];
    }];

    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animationWithKeyPath:kDBAnimationKeyFrame];
    frameAnimation.calculationMode = kCAAnimationDiscrete;
    frameAnimation.duration = self.animationDuration;
    frameAnimation.values = images;
    frameAnimation.repeatCount = 1;
    frameAnimation.removedOnCompletion = NO;
    frameAnimation.fillMode = kCAFillModeForwards;
    [icon.layer addAnimation:frameAnimation forKey:nil];
}

@end

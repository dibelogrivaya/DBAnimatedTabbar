//
//  DBTransformAnimation.m
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBTransformAnimation.h"

@import QuartzCore;

static NSString *const kDBAnimationFlip = @"transform.flip";

@interface DBTransformAnimation ()

@property (assign, nonatomic) DBTransformAnimationMode mode;

@end

@implementation DBTransformAnimation

+ (instancetype)animationWithFlipAnimationMode:(DBTransformAnimationMode)mode {
    return [[[self class] alloc] initWithFlipAnimationMode:mode];
}

- (instancetype)initWithFlipAnimationMode:(DBTransformAnimationMode)mode {
    if (self = [super init]) {
        _mode = mode;
    }
    return self;
}

- (void)animateSelectItemWithIcon:(UIImageView *)icon label:(UILabel *)label selectedColor:(UIColor *)selectedColor {
    [super animateSelectItemWithIcon:icon label:label selectedColor:selectedColor];
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        icon.layer.transform = [self transformCurrentMode];
    } completion:^(BOOL finished) {
        icon.layer.transform = CATransform3DIdentity;
    }];
}

- (CATransform3D)transformCurrentMode {
    switch (self.mode) {
        case DBTransformAnimationModeFlipVertical: return CATransform3DScale(CATransform3DMakeRotation(M_PI, 0, 0, 1), -1, 1, 1);
        case DBTransformAnimationModeFlipHorizontal: return CATransform3DScale(CATransform3DMakeRotation(M_PI, 0, 0, 1), 1, -1, 1);
        case DBTransformAnimationModeScale: return CATransform3DMakeScale(.4f, .4f, .4f);
        default: return CATransform3DIdentity;
    }
}

@end

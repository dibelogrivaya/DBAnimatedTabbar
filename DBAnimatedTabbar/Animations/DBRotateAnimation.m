//
//  DBRotateAnimation.m
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBRotateAnimation.h"

@import QuartzCore;

static NSString *const kDBAnimationRotation = @"transform.rotation";

@interface DBRotateAnimation ()

@property (assign, nonatomic) DBRotateAnimationDirection direction;

@end

@implementation DBRotateAnimation

+ (instancetype)animationWithRotateAnimationDirection:(DBRotateAnimationDirection)direction {
    return [[[self class] alloc] initWithRotateAnimationDirection:direction];
}

- (instancetype)initWithRotateAnimationDirection:(DBRotateAnimationDirection)direction {
    if (self = [super init]) {
        _direction = direction;
    }
    return self;
}

- (void)animateSelectItemWithIcon:(UIImageView *)icon label:(UILabel *)label selectedColor:(UIColor *)selectedColor {
    [super animateSelectItemWithIcon:icon label:label selectedColor:selectedColor];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:kDBAnimationRotation];
    rotateAnimation.fromValue = @0;
    rotateAnimation.toValue = [self toValueForCurrentDirection];
    rotateAnimation.duration = self.animationDuration;
    rotateAnimation.removedOnCompletion = NO;
    [icon.layer addAnimation:rotateAnimation forKey:nil];
}

- (NSNumber *)toValueForCurrentDirection {
    switch (self.direction) {
        case DBRotateAnimationDirectionLeft: return @(-M_PI * 2);
        case DBRotateAnimationDirectionRight: return @(M_PI * 2);
        default: return @1;
    }
}

@end


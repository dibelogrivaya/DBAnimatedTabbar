//
//  DBBounceAnimation.m
//  Example
//
//  Created by Diana Belogrivaya on 2/27/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBBounceAnimation.h"

static NSString *const kDBAnimationScale = @"transform.scale";

@implementation DBBounceAnimation

- (void)animateSelectItemWithIcon:(UIImageView *)icon label:(UILabel *)label selectedColor:(UIColor *)selectedColor {
    [super animateSelectItemWithIcon:icon label:label selectedColor:selectedColor];
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:kDBAnimationScale];
    bounceAnimation.values = @[@1, @1.2, @0.9, @1.1, @0.95, @1.02, @1.0];
    bounceAnimation.duration = self.animationDuration;
    bounceAnimation.calculationMode = kCAAnimationCubic;
    bounceAnimation.removedOnCompletion = NO;
    [icon.layer addAnimation:bounceAnimation forKey:nil];
}

@end



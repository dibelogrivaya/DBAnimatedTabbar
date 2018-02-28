//
//  DBRotateAnimation.h
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBTabbarItemAnimation.h"

typedef NS_ENUM(NSInteger, DBRotateAnimationDirection) {
    DBRotateAnimationDirectionLeft,
    DBRotateAnimationDirectionRight
};

@interface DBRotateAnimation : DBTabbarItemAnimation

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)animationWithRotateAnimationDirection:(DBRotateAnimationDirection)direction;

@end

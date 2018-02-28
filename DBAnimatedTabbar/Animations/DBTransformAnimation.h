//
//  DBTransformAnimation.h
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBTabbarItemAnimation.h"

typedef NS_ENUM(NSInteger, DBTransformAnimationMode) {
    DBTransformAnimationModeFlipHorizontal,
    DBTransformAnimationModeFlipVertical,
    DBTransformAnimationModeScale
};

@interface DBTransformAnimation : DBTabbarItemAnimation

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)animationWithFlipAnimationMode:(DBTransformAnimationMode)mode;

@end

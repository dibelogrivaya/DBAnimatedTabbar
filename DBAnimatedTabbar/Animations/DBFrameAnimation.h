//
//  DBFrameAnimation.h
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBTabbarItemAnimation.h"

@interface DBFrameAnimation : DBTabbarItemAnimation

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)animationWithImages:(NSArray <UIImage *> *)images;

@end

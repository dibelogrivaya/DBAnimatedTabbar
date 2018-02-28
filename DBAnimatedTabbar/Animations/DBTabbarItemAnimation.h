//
//  DBTabbarItemAnimation.h
//  Example
//
//  Created by Diana Belogrivaya on 2/27/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DBTabbarItemAnimation : NSObject 

@property (assign, nonatomic, readonly) CGFloat animationDuration;

- (void)selectItemWithIcon:(UIImageView *)icon label:(UILabel *)label selectedColor:(UIColor *)selectedColor;
- (void)deselectItemWithIcon:(UIImageView *)icon label:(UILabel *)label unselectedColor:(UIColor *)unselectedColor;;
- (void)animateSelectItemWithIcon:(UIImageView *)icon label:(UILabel *)label selectedColor:(UIColor *)selectedColor;

@end


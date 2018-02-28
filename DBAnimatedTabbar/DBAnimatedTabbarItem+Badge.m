//
//  DBAnimatedTabbarItem+Badge.m
//  Example
//
//  Created by Diana Belogrivaya on 2/27/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBAnimatedTabbarItem+Badge.h"

#import "DBBadge.h"

@implementation DBAnimatedTabbarItem (Badge)

- (NSString *)badgeValue {
    return self.badge ? self.badge.text : nil;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    if (badgeValue == nil || badgeValue.length == 0) {
        if ([self.badge respondsToSelector:@selector(removeFromSuperview)]) {
            [self.badge removeFromSuperview];
        }
        self.badge = nil;
        return;
    }
    
    if (self.itemIcon != nil && [self.itemIcon superview] != nil && self.badge == nil) {
        self.badge = [DBBadge badge];
        [self.badge addOnView:[self.itemIcon superview]];
    }
    
    if (self.badge != nil) {
        self.badge.text = badgeValue;
    }
}

@end

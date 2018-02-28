//
//  DBBadge.h
//  Example
//
//  Created by Diana Belogrivaya on 2/27/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBBadge : UILabel

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)badge;
- (void)addOnView:(UIView *)view ;

@end


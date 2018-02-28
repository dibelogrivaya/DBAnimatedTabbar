//
//  DBDemoFrameViewController.m
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBDemoFrameViewController.h"

#import "DBAnimatedTabbarItem.h"
#import "DBFrameAnimation.h"

@implementation DBDemoFrameViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSArray *images = [self imageNamesWithPrefix:@"testIconFrame" startIndex:1 endIndex:10];
        [(DBAnimatedTabbarItem *)self.tabBarItem setAnimation:[DBFrameAnimation animationWithImages:images]];
    }
    return self;
}

- (NSArray <UIImage *> *)imageNamesWithPrefix:(NSString *)prefix startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:endIndex - startIndex + 1];
    for (NSInteger index = startIndex; index <= endIndex; index ++) {
        NSString *imageName = [prefix stringByAppendingFormat:@"_%ld", (long)index];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image != nil) {
            [images addObject:image];
        }
    }
    return [images copy];
}

@end


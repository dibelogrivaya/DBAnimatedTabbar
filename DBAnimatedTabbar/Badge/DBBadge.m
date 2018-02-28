//
//  DBBadge.m
//  Example
//
//  Created by Diana Belogrivaya on 2/27/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBBadge.h"

static const CGFloat kDBDefaultBadgeSize = 18.f;

@interface DBBadge ()

@property (strong, nonatomic) NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSLayoutConstraint *centerXConstraint;

@end

@implementation DBBadge

+ (instancetype)badge {
    return [[[self class] alloc] initWithFrame:(CGRect){CGPointZero, (CGSize){kDBDefaultBadgeSize, kDBDefaultBadgeSize}}];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.backgroundColor = [UIColor redColor].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = CGRectGetWidth(frame) / 2;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self configureNumberLabel];
        [self createSizeConstraints:frame.size];
    }
    return self;
}

- (void)configureNumberLabel {
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:13.f];
    self.textColor = [UIColor whiteColor];
}

- (void)createSizeConstraints:(CGSize)size {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                        toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:size.width]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:size.height]];
}

- (CGSize)intrinsicContentSize {
    CGSize contentSize = [super intrinsicContentSize];
    contentSize.width += 10;
    return contentSize;
}

- (void)addOnView:(UIView *)view {
    [view addSubview:self];
    
    self.topConstraint = [NSLayoutConstraint constraintWithItem:self
                                                      attribute:NSLayoutAttributeTop
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view
                                                      attribute:NSLayoutAttributeTop
                                                     multiplier:1
                                                       constant:3];
    [view addConstraint:self.topConstraint];
    
    self.centerXConstraint = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:10];
    [view addConstraint:self.centerXConstraint];
}

@end


//
//  DBAnimatedTabbarController.m
//  Example
//
//  Created by Diana Belogrivaya on 2/25/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBAnimatedTabbarController.h"

#import "DBAnimatedTabbarItem.h"
#import "DBTabbarItemAnimation.h"

static NSString * const kDBContainerIdentifier = @"container";

@interface DBAnimatedTabbarController ()

@property (strong, nonatomic) NSDictionary <NSString *, UIView *> *tabbarContainers;

@end

@implementation DBAnimatedTabbarController

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [super setViewControllers:viewControllers];
    
    [self resetTabbarContainers];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> * __nullable)viewControllers animated:(BOOL)animated {
    [super setViewControllers:viewControllers animated:animated];
    
    [self resetTabbarContainers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self resetTabbarContainers];
}

- (void)resetTabbarContainers {
    if (![self isTabbarSupportAnimation]) {
        return;
    }
    
    [self.tabbarContainers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIView * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(removeFromSuperview)]) {
            [obj removeFromSuperview];
        }
    }];
    
    self.tabbarContainers = [self tabbarViewContainers];
    [self resetTabbarItems];
}

- (NSDictionary <NSString *, UIView *> *)tabbarViewContainers {
    if (self.tabBar.items.count == 0) {
        return nil;
    }
    
    NSMutableDictionary <NSString *, UIView *> *newContainers = [NSMutableDictionary new];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *viewContainer = [self tabbarViewContainer];
        newContainers[[NSString stringWithFormat:@"%@%lu", kDBContainerIdentifier, (unsigned long)idx]] = viewContainer;
    }];
    
    NSMutableString *visualFormat = [[NSMutableString alloc] initWithString:@"H:|"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [visualFormat appendFormat:@"-(0)-[%@%lu(==%@%lu)]", kDBContainerIdentifier, (unsigned long)idx, kDBContainerIdentifier, (unsigned long)0];
    }];
    [visualFormat appendString:@"-(0)-|"];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                      options:NSLayoutFormatDirectionRightToLeft metrics:nil views:newContainers]];
    return newContainers;
}

- (UIView *)tabbarViewContainer {
    UIView *viewContainer = [UIView new];
    viewContainer.backgroundColor = [UIColor clearColor];
    viewContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:viewContainer];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired = 1;
    [viewContainer addGestureRecognizer:tapGesture];
    
    if (@available(iOS 11, *)) {
        [viewContainer.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    } else {
        [viewContainer.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor].active = YES;
    }
     [viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:viewContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:49.f]];
    return viewContainer;
}

- (void)handleTap:(UIGestureRecognizer *)gesture {
    if (gesture.view == nil) { return; }
    
    NSArray <DBAnimatedTabbarItem *> *animatedItems = [self animatedTabbarItems];
    if (animatedItems.count == 0) { return; }
    
    NSInteger currentIndex = gesture.view.tag;
    DBAnimatedTabbarItem *currentItem = (DBAnimatedTabbarItem *)animatedItems[currentIndex];
    if (!currentItem.isEnabled) { return; }
    
    UIViewController *controller = self.childViewControllers[currentIndex];
    if (self.selectedIndex != currentIndex) {
        [currentItem selectAnimated:YES];
        
        DBAnimatedTabbarItem *deselectItem = (DBAnimatedTabbarItem *)animatedItems[self.selectedIndex];
        UIView *containerPrevious = [deselectItem.itemIcon superview];
        if (containerPrevious) {
            containerPrevious.backgroundColor = currentItem.containerUnselectedColor;
        }
        [deselectItem deselect];
        
        UIView *container = [currentItem.itemIcon superview];
        if (container) {
            container.backgroundColor =  currentItem.containerSelectedColor;
        }
        
        self.selectedIndex = gesture.view.tag;

    } else if (self.selectedIndex == currentIndex) {
        id selectedController = self.viewControllers[self.selectedIndex];
        if ([selectedController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)selectedController popViewControllerAnimated:YES];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [self.delegate tabBarController:self didSelectViewController:controller];
    }
}

- (void)resetTabbarItems {
    NSArray <DBAnimatedTabbarItem *> *animatedItems = [self animatedTabbarItems];
    if (animatedItems.count == 0) { return; }
    
    [animatedItems enumerateObjectsUsingBlock:^(DBAnimatedTabbarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *container = self.tabbarContainers[[NSString stringWithFormat:@"container%lu", (unsigned long)(animatedItems.count - 1 - idx)]];
        if (container == nil) { *stop = YES; }
        
        container.tag = idx;
        item.tag = idx;
        container.backgroundColor = [(DBAnimatedTabbarItem *)animatedItems[idx] containerUnselectedColor];
        
        [item addItemOnView:container maxWidth:(CGRectGetWidth(self.tabBar.frame) / animatedItems.count -  5.f)];
        
        if (idx == 0) {
            [item selectAnimated:NO];
            container.backgroundColor = [(DBAnimatedTabbarItem *)animatedItems[idx] containerSelectedColor];
        }
    }];
}

- (BOOL)isTabbarSupportAnimation {
    __block BOOL isAllItemsAnimated = YES;
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[DBAnimatedTabbarItem class]]) {
            isAllItemsAnimated = NO;
            *stop = YES;
        }
    }];
    
    if (!isAllItemsAnimated) {
        NSLog(@"%s: All tabbar items must be DBAnimatedTabbarItem", __PRETTY_FUNCTION__);
    }
    return isAllItemsAnimated;
}

- (void)changeAnimatedTabbarItemsSelectedColor:(UIColor *)selectedColor unselectedColor:(UIColor *)unselectedColor {
    [[self animatedTabbarItems] enumerateObjectsUsingBlock:^(DBAnimatedTabbarItem * _Nonnull animatedItem, NSUInteger idx, BOOL * _Nonnull stop) {
        animatedItem.selectedColor = selectedColor;
        animatedItem.unselectedColor = unselectedColor;
        
        if (animatedItem == self.tabBar.selectedItem) {
            [animatedItem selectAnimated:NO];
        }
    }];
}

- (void)changeAnimatedTabbarVisibility:(BOOL)isVisible {
    [[self animatedTabbarItems] enumerateObjectsUsingBlock:^(DBAnimatedTabbarItem * _Nonnull animatedItem, NSUInteger idx, BOOL * _Nonnull stop) {
        if (animatedItem.itemIcon != nil && [animatedItem.itemIcon superview] != nil) {
            [animatedItem.itemIcon superview].hidden = !isVisible;
        }
    }];
    self.tabBar.hidden = !isVisible;
}

#pragma mark - Helpers

- (NSArray <DBAnimatedTabbarItem *> *)animatedTabbarItems {
    __block NSArray <DBAnimatedTabbarItem *> *items = [NSArray new];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[DBAnimatedTabbarItem class]]) {
            items = [items arrayByAddingObject:(DBAnimatedTabbarItem *)obj];
        }
    }];
    return items;
}

@end


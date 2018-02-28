//
//  DBDemoViewController.m
//  Example
//
//  Created by Diana Belogrivaya on 2/28/18.
//  Copyright © 2018 Diana Belogrivaya. All rights reserved.
//

#import "DBDemoViewController.h"

#import "DBDemoTabbarController.h"

@interface DBDemoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation DBDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.numberOfLines = 0;
    self.lblTitle.text = [[DBDemoTabbarController tabbarItemTitleAtIndex:self.tabBarItem.tag] ?: @"" stringByAppendingString:@"\ranimation"];
}

@end

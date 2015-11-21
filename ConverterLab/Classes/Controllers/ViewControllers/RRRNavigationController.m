//
//  RRRNavigationController.m
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRNavigationController.h"

@implementation RRRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationBar.barStyle = UIBarStyleBlack;
  self.navigationBar.barTintColor = [UIColor colorwithHexString:@"#37474f" alpha:1];
  self.navigationBar.tintColor= [UIColor whiteColor];
}

@end

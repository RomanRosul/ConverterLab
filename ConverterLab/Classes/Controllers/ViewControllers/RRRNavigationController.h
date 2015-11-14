//
//  RRRNavigationController.h
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRHamburgerButtonView.h"
#import "RRRTableViewController.h"

@interface RRRNavigationController : UINavigationController

@property (nonatomic,strong) RRRHamburgerButtonView * hamburgerButton;
@end

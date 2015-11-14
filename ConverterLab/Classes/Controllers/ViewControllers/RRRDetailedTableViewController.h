//
//  RRRDetailedTableViewController.h
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRSingleOrganization.h"
#import "RRRHamburgerButtonView.h"
#import "RRRHamburgerOverlayView.h"

@interface RRRDetailedTableViewController : UITableViewController <HamburgerButtonDelegate, TableCellButtonsDelegate>
@property (strong,nonatomic) RRRSingleOrganization * singleOrganization;
@end

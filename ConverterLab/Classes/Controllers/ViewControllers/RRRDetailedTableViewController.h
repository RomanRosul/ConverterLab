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
#import "RRRDetailsFirstTableViewCell.h"
#import "RRRDetailsSecondTableViewCell.h"
#import <MessageUI/MessageUI.h>
#import "RRRShareView.h"

@interface RRRDetailedTableViewController : UITableViewController <HamburgerButtonDelegate, TableCellButtonsDelegate, MFMailComposeViewControllerDelegate,ShareButtonDelegate>
@property (strong,nonatomic) RRRSingleOrganization * singleOrganization;
@end

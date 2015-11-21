//
//  RRRBaseTableViewController.h
//  ConverterLab
//
//  Created by Roman R on 21.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRTableViewCell.h"
#import "RRRDataBaseManager.h"
#import "RRRMapViewController.h"

@interface RRRBaseTableViewController : UITableViewController <TableCellButtonsDelegate>
- (void)displayError:(NSString *)message;
@end

//
//  RRRTableViewController.h
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "RRRNetworkManager.h"
#import "RRRDataBaseManager.h"
#import "RRRTableViewCell.h"
#import "RRRMapViewController.h"
#import "RRRDetailedTableViewController.h"
#import "RRRSingleOrganization.h"
#import "RRRBaseTableViewController.h"

@interface RRRTableViewController : RRRBaseTableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate, DataBaseManagerDelegate, UISearchResultsUpdating>

@end

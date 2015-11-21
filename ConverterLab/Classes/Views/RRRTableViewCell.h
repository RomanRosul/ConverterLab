//
//  RRRTableViewCell.h
//  ConverterLab
//
//  Created by Roman R on 13.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRSingleOrganization.h"

@protocol TableCellButtonsDelegate <NSObject>
@required
- (void)buttonURLPressed:(NSString *)link ;
- (void)buttonMapPressed:(RRRSingleOrganization *)aSingleOrganization;
- (void)buttonCallPressed:(NSString *)phone;
@optional
- (void)buttonDetailedInfoPressed:(RRRSingleOrganization *)aSingleOrganization;
@end

@interface RRRTableViewCell : UITableViewCell
@property (nonatomic, weak) id <TableCellButtonsDelegate> delegateInstance;
- (void) configureCellWithData:(RRRSingleOrganization *) singleOrganization forIndexPath:(NSIndexPath *)indexPath;


@end

//
//  RRRDetailsFirstTableViewCell.h
//  ConverterLab
//
//  Created by Roman R on 15.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRSingleOrganization.h"

@interface RRRDetailsFirstTableViewCell : UITableViewCell
- (void) configureCellWithData:(RRRSingleOrganization *) singleOrganization;
@end

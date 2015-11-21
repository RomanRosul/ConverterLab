//
//  RRRDetailsSecondTableViewCell.h
//  ConverterLab
//
//  Created by Roman R on 16.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRSingleCurrency.h"

@interface RRRDetailsSecondTableViewCell : UITableViewCell
- (void) configureCellWithData:(RRRSingleCurrency *) currency;
@end

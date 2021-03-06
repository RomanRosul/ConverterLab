//
//  RRRHamburgerOverlayView.h
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRTableViewCell.h"
#import "UIView+showHide.h"

@interface RRRHamburgerOverlayView : UIView
@property (nonatomic, weak) id <TableCellButtonsDelegate> delegateInstance;
- (instancetype) initWithFrame:(CGRect)frame andData:(RRRSingleOrganization *)aSingleOrganization;
@end

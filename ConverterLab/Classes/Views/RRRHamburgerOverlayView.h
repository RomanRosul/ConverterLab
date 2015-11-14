//
//  RRRHamburgerOverlayView.h
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRTableViewCell.h"

@interface RRRHamburgerOverlayView : UIView

@property (nonatomic, weak) id <TableCellButtonsDelegate> delegateInstance;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UILabel *callLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;
@property (weak, nonatomic) IBOutlet UILabel *mapLabel;

@end

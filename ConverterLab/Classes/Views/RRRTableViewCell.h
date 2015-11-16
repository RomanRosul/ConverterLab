//
//  RRRTableViewCell.h
//  ConverterLab
//
//  Created by Roman R on 13.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableCellButtonsDelegate <NSObject>
@required
- (void)buttonURLPressed:(NSNumber *)tableRow;
- (void)buttonMapPressed:(NSNumber *)tableRow;
- (void)buttonCallPressed:(NSNumber *)tableRow;
@optional
- (void)buttonDetailedInfoPressed:(NSNumber *)tableRow;
@end

@interface RRRTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *detailsButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) id <TableCellButtonsDelegate> delegateInstance;
@property (nonatomic, strong) CALayer *borderBottom;


@end

//
//  RRRDetailsFirstTableViewCell.m
//  ConverterLab
//
//  Created by Roman R on 15.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRDetailsFirstTableViewCell.h"

@interface RRRDetailsFirstTableViewCell ()
//@property (nonatomic, strong) RRRSingleOrganization * singleOrganization;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIView *content;
@end


@implementation RRRDetailsFirstTableViewCell

- (void)awakeFromNib {
  self.content.layer.shadowOffset = CGSizeMake(1, 0);
  self.content.layer.shadowColor = [[UIColor blackColor] CGColor];
  self.content.layer.shadowRadius = 5;
  self.content.layer.shadowOpacity = .25;
}

- (void) configureCellWithData:(RRRSingleOrganization *) singleOrganization {
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.titleLabel.text = singleOrganization.title;
  self.linkLabel.text = [NSString stringWithFormat:@"%@",singleOrganization.link];
  self.addressLabel.text = [NSString stringWithFormat:@"Адрес: %@",singleOrganization.address];
  self.phoneLabel.text = [NSString stringWithFormat:@"Телефон: %@",singleOrganization.phone];
}


@end

//
//  RRRDetailsSecondTableViewCell.m
//  ConverterLab
//
//  Created by Roman R on 16.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRDetailsSecondTableViewCell.h"

@interface RRRDetailsSecondTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *upImage;
@property (weak, nonatomic) IBOutlet UIImageView *downImage;
@end

@implementation RRRDetailsSecondTableViewCell

- (void)awakeFromNib {
   self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) configureCellWithData:(RRRSingleCurrency *) currency {
  self.titleLabel.text = currency.localizedTitle;
  self.buyLabel.text = [currency.bid description];
  self.sellLabel.text = [currency.ask description];
  self.upImage.alpha =1;
  self.downImage.alpha =1;
}


@end

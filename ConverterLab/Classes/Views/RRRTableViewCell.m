//
//  RRRTableViewCell.m
//  ConverterLab
//
//  Created by Roman R on 13.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRTableViewCell.h"
#import "UIColor+fromHex.h"

@interface RRRTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *detailsButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) CALayer *borderBottom;
@property (strong,nonatomic) RRRSingleOrganization * singleOrganization;
@end

@implementation RRRTableViewCell

- (void)awakeFromNib {
  self.contentView.layer.shadowOffset = CGSizeMake(1, 0);
  self.contentView.layer.shadowColor = [[UIColor blackColor] CGColor];
  self.contentView.layer.shadowRadius = 5;
  self.contentView.layer.shadowOpacity = .25;  
}

- (void) configureCellWithData:(RRRSingleOrganization *) aSingleOrganization forIndexPath:(NSIndexPath *)indexPath {
  self.singleOrganization = aSingleOrganization;
  self.titleLabel.text = self.singleOrganization.title;
  self.regionLabel.text = self.singleOrganization.region;
  self.cityLabel.text = self.singleOrganization.city;
  self.phoneLabel.text = [NSString stringWithFormat:@"Тел: %@", self.singleOrganization.phone ];
 self.addressLabel.text = [NSString stringWithFormat:@"Адрес: %@",self.singleOrganization.address];
  self.linkButton.tag = indexPath.row;
  self.mapButton.tag = indexPath.row;
  self.callButton.tag = indexPath.row;
  self.detailsButton.tag = indexPath.row;
}

- (IBAction)openURLPressed:(id)sender {
  SEL selector = @selector(buttonURLPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:self.singleOrganization.link];
  }
  [self.borderBottom removeFromSuperlayer];
}

- (IBAction)linkButtonTouch:(id)sender {
  [self addUnderlineTo:self.linkButton];
  [self.linkButton setImage:[UIImage imageNamed:@"ic_link_active"] forState:UIControlStateHighlighted];
}

- (IBAction)openMapPressed:(id)sender {
  SEL selector = @selector(buttonMapPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:self.singleOrganization];
  }
  [self.borderBottom removeFromSuperlayer];
}

- (IBAction)mapButtonTouch:(id)sender {
  [self addUnderlineTo:self.mapButton];
  [self.mapButton setImage:[UIImage imageNamed:@"ic_mark_active"] forState:UIControlStateHighlighted];

}

- (IBAction)callPressed:(id)sender {
  SEL selector = @selector(buttonCallPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:self.singleOrganization.phone];
  }
  [self.borderBottom removeFromSuperlayer];
}

- (IBAction)callButtonTouch:(id)sender {
  [self addUnderlineTo:self.callButton];
  [self.callButton setImage:[UIImage imageNamed:@"ic_phone_active"] forState:UIControlStateHighlighted];

}

- (IBAction)detailedInfoPressed:(id)sender {
  SEL selector = @selector(buttonDetailedInfoPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:self.singleOrganization];
  }
  [self.borderBottom removeFromSuperlayer];
}

- (IBAction)detailedButtonTouch:(id)sender {
  [self.detailsButton setImage:[UIImage imageNamed:@"ic_dots_active"] forState:UIControlStateHighlighted];
  [self addUnderlineTo:self.detailsButton];
}

- (void)addUnderlineTo:(UIButton *)button {
  self.borderBottom = [CALayer layer];
  self.borderBottom.backgroundColor = [UIColor colorwithHexString:@"#ff4081" alpha:1].CGColor;
  self.borderBottom.frame = CGRectMake(0,button.frame.size.height, button.frame.size.width, 2);
  [button.layer addSublayer:self.borderBottom];
}

@end

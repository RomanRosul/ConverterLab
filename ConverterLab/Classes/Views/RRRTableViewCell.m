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
@end

@implementation RRRTableViewCell

- (void)awakeFromNib {
  self.contentView.layer.shadowOffset = CGSizeMake(1, 0);
  self.contentView.layer.shadowColor = [[UIColor blackColor] CGColor];
  self.contentView.layer.shadowRadius = 5;
  self.contentView.layer.shadowOpacity = .25;  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)openURLPressed:(id)sender {
  SEL selector = @selector(buttonURLPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:[NSNumber numberWithInteger:[sender tag]]];
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
    [self.delegateInstance performSelector:selector withObject:[NSNumber numberWithInteger:[sender tag]]];
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
    [self.delegateInstance performSelector:selector withObject:[NSNumber numberWithInteger:[sender tag]]];
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
    [self.delegateInstance performSelector:selector withObject:[NSNumber numberWithInteger:[sender tag]]];
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

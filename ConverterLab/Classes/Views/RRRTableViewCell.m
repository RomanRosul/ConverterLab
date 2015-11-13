//
//  RRRTableViewCell.m
//  ConverterLab
//
//  Created by Roman R on 13.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRTableViewCell.h"

@implementation RRRTableViewCell

- (void)awakeFromNib {
    // Initialization code
  
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
}

- (IBAction)openMapPressed:(id)sender {
  SEL selector = @selector(buttonMapPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:[NSNumber numberWithInteger:[sender tag]]];
  }
}

- (IBAction)callPressed:(id)sender {
  SEL selector = @selector(buttonCallPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:[NSNumber numberWithInteger:[sender tag]]];
  }
}
- (IBAction)detailedInfoPressed:(id)sender {
  SEL selector = @selector(buttonDetailedInfoPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:[NSNumber numberWithInteger:[sender tag]]];
  }
  
}

@end

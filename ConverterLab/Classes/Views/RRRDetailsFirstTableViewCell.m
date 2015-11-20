//
//  RRRDetailsFirstTableViewCell.m
//  ConverterLab
//
//  Created by Roman R on 15.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRDetailsFirstTableViewCell.h"


@implementation RRRDetailsFirstTableViewCell

- (void)awakeFromNib {
  
  self.content.layer.shadowOffset = CGSizeMake(1, 0);
  self.content.layer.shadowColor = [[UIColor blackColor] CGColor];
  self.content.layer.shadowRadius = 5;
  self.content.layer.shadowOpacity = .25;
}


@end

//
//  RRRHamburgerView.m
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRHamburgerButtonView.h"
#import "UIColor+fromHex.h"

@implementation RRRHamburgerButtonView

- (instancetype) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self)
  {
    self.alpha = 0;
    [self setImage:[UIImage imageNamed:@"ic_hamburger"] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor colorwithHexString:@"#f06292" alpha:1];
    self.layer.cornerRadius = self.frame.size.width/2;
    [self  addTarget:self action:@selector(hamburgerPressed) forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

- (void)hamburgerPressed { 
  SEL selector = @selector(hamburgerDidPressed);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector];
  }
}

@end

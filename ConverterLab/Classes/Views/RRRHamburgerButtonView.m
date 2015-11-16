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
    UIButton * hamburgerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [hamburgerButton setImage:[UIImage imageNamed:@"ic_hamburger"] forState:UIControlStateNormal];
    hamburgerButton.backgroundColor = [UIColor colorwithHexString:@"#f06292" alpha:1];
    [self addSubview:hamburgerButton];
    hamburgerButton.layer.cornerRadius = hamburgerButton.frame.size.width/2;
    [hamburgerButton  addTarget:self
                                  action:@selector(hamburgerPressed)
                        forControlEvents:UIControlEventTouchUpInside];
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

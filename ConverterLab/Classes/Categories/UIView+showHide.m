//
//  UIView+showHide.m
//  ConverterLab
//
//  Created by Roman R on 21.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "UIView+showHide.h"

@implementation UIView (showHide)

- (void) showMeAnimated {
  [UIView animateWithDuration:0.5 animations:^{
    self.alpha = 1;
  }];
}

- (void) hideMeAnimated {
  [UIView animateWithDuration:0.5 animations:^{
    self.alpha = 0;
  } completion:^(BOOL finished) {
    [self removeFromSuperview];
  }];
}

@end

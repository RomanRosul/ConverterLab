//
//  RRRHamburgerOverlayView.m
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRHamburgerOverlayView.h"
#import "RRRNavigationController.h"

@implementation RRRHamburgerOverlayView

- (instancetype) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self)
  {
   // self.frame = [[UIScreen mainScreen]bounds];
    
    NSArray *theView =  [[NSBundle mainBundle] loadNibNamed:@"RRRHamburgerOverlayView" owner:self options:nil];
    UIView *nv = [theView objectAtIndex:0];
    [self addSubview:nv];
    nv.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    [self makeCirkleFrom:self.closeButton];
    [self makeCirkleFrom:self.callButton];
    [self makeCirkleFrom:self.mapButton];
    [self makeCirkleFrom:self.linkButton];
  }
  return self;
}

- (void)makeCirkleFrom:(UIButton *)aButton {
  aButton.layer.cornerRadius = aButton.frame.size.width/2;
}

- (IBAction)closeButtonPressed:(id)sender {
  [self removeFromSuperview];
}

- (IBAction)callButtonPressed:(id)sender {
  [self removeFromSuperview];
  SEL selector = @selector(buttonCallPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:[NSNumber numberWithInteger:[sender tag]]];
  }
}

- (IBAction)linkButtonPressed:(id)sender {
  [self removeFromSuperview];
  SEL selector = @selector(buttonURLPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:[NSNumber numberWithInteger:[sender tag]]];
  }
}

- (IBAction)mapButtonPressed:(id)sender {
  [self removeFromSuperview];  
  SEL selector = @selector(buttonMapPressed:);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector withObject:[NSNumber numberWithInteger:[sender tag]]];
  }
}

@end

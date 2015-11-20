//
//  RRRHamburgerOverlayView.m
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRHamburgerOverlayView.h"
#import "RRRNavigationController.h"
#import "UIColor+fromHex.h"

@interface RRRHamburgerOverlayView ()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UILabel *callLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;
@property (weak, nonatomic) IBOutlet UILabel *mapLabel;

@end

@implementation RRRHamburgerOverlayView

- (instancetype) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self)
  {
    NSArray *theViewArray =  [[NSBundle mainBundle] loadNibNamed:@"RRRHamburgerOverlayView" owner:self options:nil];
    UIView *theView = [theViewArray objectAtIndex:0];
    theView.frame = self.frame;
    [self addSubview:theView];
    theView.backgroundColor = [UIColor colorwithHexString:@"#eeeeee" alpha:0.9];
    [self makeCirkleFrom:self.closeButton];
    [self makeCirkleFrom:self.callButton];
    [self makeCirkleFrom:self.mapButton];
    [self makeCirkleFrom:self.linkButton];
    [self setShadow:self.mapLabel];
    [self setShadow:self.linkLabel];
    [self setShadow:self.callLabel];
    [self setShadow:self.mapButton];
    [self setShadow:self.linkButton];
    [self setShadow:self.callButton];
    [self setShadow:self.closeButton];
  }
  return self;
}

- (void)setShadow:(UIView *)view {
  view.layer.shadowOffset = CGSizeMake(1, 0);
  view.layer.shadowColor = [[UIColor blackColor] CGColor];
  view.layer.shadowRadius = 5;
  view.layer.shadowOpacity = .25;
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

//
//  RRRShareView.m
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRShareView.h"
#import "UIColor+fromHex.h"

@implementation RRRShareView

- (instancetype) initWithFrame:(CGRect)frame  andData: (RRRSingleOrganization *)aSingleOrganization {
  self = [super initWithFrame:frame];
  if (self)
  {
    UIView * backgroundView = [[UIView alloc] initWithFrame:self.frame];
                               //CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-100)];
    backgroundView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.7];
    [self addSubview:backgroundView];
    
    UIView * contentView = [[UIView alloc] initWithFrame: CGRectMake(10, 80, self.frame.size.width-20, self.frame.size.height-200)];
    contentView.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:contentView];
    
    //UIView * detailedTitleView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 40)];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 260, 20)];
    titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:22.0f];
   // titleLabel.font.
    
    UILabel * regionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 260, 15)];
    regionLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16.0f];
    regionLabel.textColor = [UIColor colorwithHexString:@"#546e7a" alpha:1];
    
    
    UILabel * cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 260, 15)];
    cityLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16.0f];
    cityLabel.textColor = [UIColor colorwithHexString:@"#546e7a" alpha:1];
    
    
    //titleLabel.backgroundColor = [UIColor redColor];
    //subtitleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = aSingleOrganization.title;       //@"title";
    regionLabel.text = aSingleOrganization.region;
    cityLabel.text = aSingleOrganization.city;
    [contentView addSubview:titleLabel];
    [contentView addSubview:regionLabel];
    [contentView addSubview:cityLabel];
    
   // NSString * labelName;
    for (NSInteger i=0; i<aSingleOrganization.currencies.count && i<5; i++) {
      RRRSingleCurrency * singleCurrency = (RRRSingleCurrency *)aSingleOrganization.currencies[i];
      UILabel * currencyKeyTitle = [[UILabel alloc] initWithFrame:CGRectMake(25, 120+(i*40), 50, 20)];
      currencyKeyTitle.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20.0f];
      currencyKeyTitle.textColor = [UIColor colorwithHexString:@"#c51162" alpha:1];
      
      UILabel * currencyValue = [[UILabel alloc] initWithFrame:CGRectMake(175, 120+(i*40), 100, 20)];
      currencyValue.textAlignment = NSTextAlignmentRight;
      currencyValue.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16.0f];
      currencyValue.textColor = [UIColor colorwithHexString:@"#546e7a" alpha:1];
      
      currencyValue.text = [NSString stringWithFormat:@"%@/%@",[self formatedValue:singleCurrency.ask],[self formatedValue:singleCurrency.bid]];
      currencyKeyTitle.text = singleCurrency.keyTitle;
      [contentView addSubview:currencyKeyTitle];
      [contentView addSubview:currencyValue];
    }
    
    //[contentView addSubview:detailedTitleView];
    
    UIButton * shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, contentView.frame.size.height-50, contentView.frame.size.width, 50)];
    shareButton.backgroundColor = [UIColor colorwithHexString:@"#b0bec5" alpha:1 ];
    [shareButton setTitle:@"SHARE" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:22.0f];
    [shareButton setTitleColor:[UIColor colorwithHexString:@"#f06292" alpha:1] forState:UIControlStateNormal];
    
    [contentView addSubview:shareButton];
  
    [shareButton  addTarget:self
                         action:@selector(shareButtonPressed)
              forControlEvents:UIControlEventTouchUpInside];
    
    //contentView.frame = CGRectMake(10, 80, self.frame.size.width-20, self.frame.size.height-300);
  }
  return self;
}

- (NSString *)formatedValue:(NSNumber *)aNumber {
  if ([aNumber floatValue] < 10) {
    return  [NSString stringWithFormat:@"0%.2f",[aNumber floatValue]];
  } else {
    return [NSString stringWithFormat:@"%.2f",[aNumber floatValue]];
  }
}

- (void)shareButtonPressed {
  // NSLog(@"ham");
  [self removeFromSuperview];
  SEL selector = @selector(ShareDidPressed);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector];
  }  
}


@end

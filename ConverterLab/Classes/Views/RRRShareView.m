//
//  RRRShareView.m
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRShareView.h"
#import "UIColor+fromHex.h"

@interface RRRShareView ()
@property (strong,nonatomic) RRRSingleOrganization * singleOrganization;
@end

@implementation RRRShareView

- (instancetype) initWithFrame:(CGRect)frame  andData: (RRRSingleOrganization *)aSingleOrganization {
  self = [super initWithFrame:frame];
  if (self)
  {
    self.alpha = 0;
    self.singleOrganization = aSingleOrganization;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    UIView * contentView = [[UIView alloc] initWithFrame: CGRectMake(10, 80, self.frame.size.width-20, self.frame.size.height-200)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(<=60)-[contentView]" options:0 metrics:nil views:@{ @"contentView" : contentView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[contentView]-10-|" options:0 metrics:nil views:@{ @"contentView" : contentView}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.7f constant:0]];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 260, 20)];
    titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:22.0f];
    UILabel * regionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 260, 15)];
    regionLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16.0f];
    regionLabel.textColor = [UIColor colorwithHexString:@"#546e7a" alpha:1];
    UILabel * cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, 260, 15)];
    cityLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16.0f];
    cityLabel.textColor = [UIColor colorwithHexString:@"#546e7a" alpha:1];
    titleLabel.text = aSingleOrganization.title;
    regionLabel.text = aSingleOrganization.region;
    cityLabel.text = aSingleOrganization.city;
    [contentView addSubview:titleLabel];
    [contentView addSubview:regionLabel];
    [contentView addSubview:cityLabel];
    
     UITableView * currenciesTable = [[UITableView alloc] initWithFrame:CGRectMake(25, 85, 250, 200) style:UITableViewStylePlain];    
    currenciesTable.dataSource = self;
    currenciesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView addSubview:currenciesTable];
     currenciesTable.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[currenciesTable]-10-|" options:0 metrics:nil views:@{ @"currenciesTable" : currenciesTable}]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-85-[currenciesTable]" options:0 metrics:nil views:@{ @"currenciesTable" : currenciesTable}]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:currenciesTable attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeHeight multiplier:0.41f constant:0]];
    
    UIButton * shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, contentView.frame.size.height-50, contentView.frame.size.width, 50)];
    shareButton.backgroundColor = [UIColor colorwithHexString:@"#b0bec5" alpha:1 ];
    [shareButton setTitle:@"SHARE" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:22.0f];
    [shareButton setTitleColor:[UIColor colorwithHexString:@"#f06292" alpha:1] forState:UIControlStateNormal];
    [contentView addSubview:shareButton];
    shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[shareButton(50)]|" options:0 metrics:nil views:@{ @"shareButton" : shareButton}]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[shareButton]|" options:0 metrics:nil views:@{ @"shareButton" : shareButton}]];
    [shareButton  addTarget:self
                         action:@selector(shareButtonPressed)
              forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return  self.singleOrganization.currencies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Currency"];
  if (!cell)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Currency"];
  }
  RRRSingleCurrency * singleCurrency = (RRRSingleCurrency *)self.singleOrganization.currencies[indexPath.row];
  cell.textLabel.text = singleCurrency.keyTitle;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@",[self formatedValue:singleCurrency.ask],[self formatedValue:singleCurrency.bid]];
  cell.textLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20.0f];
  cell.textLabel.textColor = [UIColor colorwithHexString:@"#c51162" alpha:1];
  cell.detailTextLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16.0f];
  cell.detailTextLabel.textColor = [UIColor colorwithHexString:@"#546e7a" alpha:1];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;  
  return cell;
}

- (NSString *)formatedValue:(NSNumber *)aNumber {
  if ([aNumber floatValue] < 10) {
    return  [NSString stringWithFormat:@"0%.2f",[aNumber floatValue]];
  } else {
    return [NSString stringWithFormat:@"%.2f",[aNumber floatValue]];
  }
}

- (void)shareButtonPressed {
  [self hideMeAnimated];
  SEL selector = @selector(ShareDidPressed);
  if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
  {
    [self.delegateInstance performSelector:selector];
  }  
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  
  UITouch *touch = [touches anyObject];
  if ([touch view] == self)
  {
    [self hideMeAnimated];
  }
}

@end

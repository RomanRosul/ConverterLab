//
//  RRRDetailedTableViewController.m
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRDetailedTableViewController.h"
#import "RRRNavigationController.h"
#import "RRRShareView.h"
#import "UIColor+fromHex.h"


@interface RRRDetailedTableViewController ()

@end

@implementation RRRDetailedTableViewController

-(instancetype)initWithData:(RRRSingleOrganization *)aSingleOrganization {
  self = [super init];
  if (self)
  {
    self.singleOrganization = aSingleOrganization;
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.backgroundColor = [UIColor colorwithHexString:@"#eeeeee" alpha:1];
  UIView * detailedTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
  UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
  UILabel * subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 200, 20)];
  titleLabel.textColor = [UIColor whiteColor];
  titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:16.0f];
  subtitleLabel.textColor = [UIColor whiteColor];
  subtitleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14.0f];
  titleLabel.text = self.singleOrganization.title;  
  subtitleLabel.text = self.singleOrganization.city;
  [detailedTitleView addSubview:titleLabel];
  [detailedTitleView addSubview:subtitleLabel];
  self.navigationItem.titleView = detailedTitleView;
  UIImage* navBarShareImage = [UIImage imageNamed:@"ic_share"];
  UIBarButtonItem *navBarShareButton = [[UIBarButtonItem alloc] initWithImage:navBarShareImage style:UIBarButtonItemStylePlain target:self action:@selector(navBarShareButtonPressed)];
  self.navigationItem.rightBarButtonItem = navBarShareButton;
}

- (void) viewWillAppear:(BOOL)animated {
  RRRNavigationController * navController = (RRRNavigationController *)self.navigationController;
  navController.hamburgerButton = [[RRRHamburgerButtonView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width-65, [[UIScreen mainScreen]bounds].size.height-68, 55, 55)];
  [navController.view addSubview: navController.hamburgerButton];
  navController.hamburgerButton.delegateInstance = self;
  navController.hamburgerButton.translatesAutoresizingMaskIntoConstraints = NO;
  [navController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[hamburger(55)]-13-|" options:0 metrics:nil views:@{ @"hamburger" : navController.hamburgerButton}]];
  [navController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[hamburger(55)]-10-|" options:0 metrics:nil views:@{ @"hamburger" : navController.hamburgerButton}]];
  [navController.hamburgerButton showMeAnimated];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.singleOrganization.currencies.count+2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row)
  {
    case 0: return 130;
    case 1: return 55;
    default: return 50;
  }
  return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  switch (indexPath.row)
  {
    case 0: return [self cellForDetailedInfoForIndexPath:indexPath];
    case 1: return [self cellForCurrencyesHeaderForIndexPath:indexPath];
    default: return [self cellForCurrenciesListForIndexPath:indexPath];
  }
    return nil;
}

- (UITableViewCell *)cellForDetailedInfoForIndexPath:(NSIndexPath *)indexPath {
  NSString *cellID = @"FirstCell";
  [self.tableView registerNib:[UINib nibWithNibName:@"RRRDetailsFirstTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
  RRRDetailsFirstTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  if (cell == nil) {
    cell = [[RRRDetailsFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellID];
  }
  [cell configureCellWithData:self.singleOrganization];
  return cell;
}

- (UITableViewCell *)cellForCurrencyesHeaderForIndexPath:(NSIndexPath *)indexPath {
  NSString *cellID = @"SecondCell";
  [self.tableView registerNib:[UINib nibWithNibName:@"RRRDetailsSecondTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
  RRRDetailsSecondTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  if (cell == nil) {
    cell = [[RRRDetailsSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:cellID];
  }
  return cell;
}

- (UITableViewCell *)cellForCurrenciesListForIndexPath:(NSIndexPath *)indexPath {
  NSInteger index = indexPath.row-2;
  NSString *cellID = @"OtherCell";
  [self.tableView registerNib:[UINib nibWithNibName:@"RRRDetailsSecondTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
  RRRDetailsSecondTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  if (cell == nil) {
    cell = [[RRRDetailsSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:cellID];
  }
  [cell configureCellWithData:self.singleOrganization.currencies[index]];
  return cell;
}

#pragma mark - Hamburger button delegate

- (void) hamburgerDidPressed {
  RRRHamburgerOverlayView * overlayView = [[ RRRHamburgerOverlayView alloc] initWithFrame:[[UIScreen mainScreen]bounds] andData:self.singleOrganization];
  [overlayView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
  overlayView.delegateInstance = self;
  [self.navigationController.view addSubview:overlayView];
  [overlayView showMeAnimated];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
  switch (result) {
    case MFMailComposeResultSent:
      NSLog(@"You sent the email.");
      break;
    case MFMailComposeResultSaved:
      NSLog(@"You saved a draft of this email");
      break;
    case MFMailComposeResultCancelled:
      NSLog(@"You cancelled sending this email.");
      break;
    case MFMailComposeResultFailed:
      NSLog(@"Mail failed:  An error occurred when trying to compose this email");
      break;
    default:
      NSLog(@"An error occurred when trying to compose this email");
      break;
  }
  
  [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - other

- (void)navBarShareButtonPressed {
  RRRShareView * shareView = [[RRRShareView alloc] initWithFrame:self.view.frame andData:self.singleOrganization];
  shareView.delegateInstance = self;
  [shareView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
  [self.navigationController.view addSubview: shareView];
  [shareView showMeAnimated];
}

- (void) ShareDidPressed {
  if ([MFMailComposeViewController canSendMail])
  {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker setMailComposeDelegate:self];
    [picker setSubject:self.singleOrganization.title];
    [picker setMessageBody:[self.singleOrganization description] isHTML:NO];
    [picker setToRecipients:@[@"testingEmail@example.com"]];
//    [self presentViewController:picker animated:YES completion:NULL];    
    [self displayError:@"Simulator cannot send email"];
  }
  else
  {
    NSLog(@"This device cannot send email");
  }
}

@end

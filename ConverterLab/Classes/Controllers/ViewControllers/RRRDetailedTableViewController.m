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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

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

//- (UITableViewCell *)blankCell
//{
//  NSString *cellID = @"Cell";
//  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
//  cell.selectionStyle = UITableViewCellSelectionStyleNone;
//  return cell;
//}

- (UITableViewCell *)cellForDetailedInfoForIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellID = @"FirstCell";
  [self.tableView registerNib:[UINib nibWithNibName:@"RRRDetailsFirstTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
  RRRDetailsFirstTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  if (cell == nil) {
    cell = [[RRRDetailsFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellID];
  }
 // UINib * cellNib = [UINib nibWithNibName:@"RRRDetailsFirstTableViewCell" bundle:nil];
  //
  
//  RRRDetailsFirstTableViewCell *cell = [[RRRDetailsFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.titleLabel.text = self.singleOrganization.title;
  cell.linkLabel.text = [NSString stringWithFormat:@"%@",self.singleOrganization.link];
  cell.addressLabel.text = [NSString stringWithFormat:@"Адрес: %@",self.singleOrganization.address];
  cell.phoneLabel.text = [NSString stringWithFormat:@"Телефон: %@",self.singleOrganization.phone];  
  
  return cell;
}

- (UITableViewCell *)cellForCurrencyesHeaderForIndexPath:(NSIndexPath *)indexPath

{
  NSString *cellID = @"SecondCell";
  [self.tableView registerNib:[UINib nibWithNibName:@"RRRDetailsSecondTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
  RRRDetailsSecondTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  if (cell == nil) {
    cell = [[RRRDetailsSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:cellID];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  RRRSingleCurrency * currency =self.singleOrganization.currencies[index];
  cell.titleLabel.text = currency.localizedTitle;
  cell.buyLabel.text = [currency.bid description];
  cell.sellLabel.text = [currency.ask description];
  cell.upImage.alpha =1;
  cell.downImage.alpha =1;
  return cell;
}

#pragma mark - Hamburger button delegate

- (void) hamburgerDidPressed {
  RRRHamburgerOverlayView * overlayView = [[ RRRHamburgerOverlayView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
  overlayView.delegateInstance = self;
  [self.navigationController.view addSubview:overlayView];
}

#pragma mark - Table Cell Buttons delegate

- (void)buttonURLPressed:(NSNumber *)tableRow {
  NSURL *url = [NSURL URLWithString:self.singleOrganization.link];
  [[UIApplication sharedApplication] openURL:url];
}

- (void)buttonMapPressed:(NSNumber *)tableRow {
   NSString * fullAddressString = [NSString stringWithFormat:@"Ukraine, %@, %@, %@",self.singleOrganization.region,self.singleOrganization.city,self.singleOrganization.address];
  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  [geocoder geocodeAddressString:fullAddressString completionHandler:^(NSArray *placemarks, NSError *error) {
    if (error != nil)
    {
      [self displayError:[NSString stringWithFormat:@"Geocode failed with error: %@", error]];
      return;
    }
    CLPlacemark *placemark = (CLPlacemark *)placemarks[0];
    RRRMapViewController * locationViewController = [RRRMapViewController new];
   // locationViewController.view.frame = self.view.frame;
    RRRNavigationController * navController = (RRRNavigationController *)self.navigationController;
    if (navController.hamburgerButton) {
      [navController.hamburgerButton removeFromSuperview];
    }
    locationViewController.location = placemark.location;
    [self.navigationController pushViewController:locationViewController animated:YES];
  }];
}

- (void)buttonCallPressed:(NSNumber *)tableRow {
   NSString *cleanedString = [[self.singleOrganization.phone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
  NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:+38%@", cleanedString]];
  NSLog(@"calling to %@",telURL);
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
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
  [self.navigationController.view addSubview: shareView];
}

- (void) ShareDidPressed {
  if ([MFMailComposeViewController canSendMail])
  {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker setMailComposeDelegate:self];
    //[self presentViewController:picker animated:YES completion:NULL];
  }
  else
  {
    NSLog(@"This device cannot send email");
  }

}

- (void)displayError:(NSString *)message
{
  dispatch_async(dispatch_get_main_queue(),^ {    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"Message"
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =
    [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                             
                           }];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
  });
}

@end

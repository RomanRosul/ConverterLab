//
//  RRRDetailedTableViewController.m
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRDetailedTableViewController.h"
#import "RRRNavigationController.h"

@interface RRRDetailedTableViewController ()

@end

@implementation RRRDetailedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.backgroundColor = [UIColor yellowColor];
  
  UIView * detailedTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
  UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
  UILabel * subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 200, 20)];
  titleLabel.backgroundColor = [UIColor redColor];
  subtitleLabel.backgroundColor = [UIColor greenColor];
  titleLabel.text = self.singleOrganization.title;       //@"title";
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  switch (indexPath.row)
  {
    case 0: return [self cellForDetailedInfo];
    case 1: return [self cellForCurrencyesHeader];
    default: return [self cellForCurrenciesList:indexPath.row];
  }
    return nil;
}

- (UITableViewCell *)blankCell
{
  NSString *cellID = @"Cell";
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

- (UITableViewCell *)cellForDetailedInfo
{
  NSString *cellID = @"Cell";
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
   cell.textLabel.text = self.singleOrganization.title;
  return cell;
}

- (UITableViewCell *)cellForCurrencyesHeader
{
  NSString *cellID = @"Cell";
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.text = @"buy/sell";
  return cell;
}

- (UITableViewCell *)cellForCurrenciesList:(NSInteger)index {
  NSString *cellID = @"Cell";
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  RRRSingleCurrency * currency =self.singleOrganization.currencies[index-2];
  cell.textLabel.text = [currency.ask description];
  cell.detailTextLabel.text = [currency.bid description];
  return cell;
}

#pragma mark - Hamburger button delegate

- (void) hamburgerDidPressed {
  
  RRRHamburgerOverlayView * overlayView = [[ RRRHamburgerOverlayView alloc] init];
  overlayView.delegateInstance = self;
  [self.navigationController.view addSubview:overlayView];
}

#pragma mark - Table Cell Buttons delegate

- (void)buttonURLPressed:(NSNumber *)tableRow {
 // NSIndexPath *path = [NSIndexPath indexPathForRow:[tableRow integerValue] inSection:0];
 // NSManagedObject *managedObject = [self.dataFetchedResultsController objectAtIndexPath:path];
  NSURL *url = [NSURL URLWithString:self.singleOrganization.link];
  [[UIApplication sharedApplication] openURL:url];
}

- (void)buttonMapPressed:(NSNumber *)tableRow {
  
  RRRNavigationController * navController = (RRRNavigationController *)self.navigationController;
  if (navController.hamburgerButton) {
    [navController.hamburgerButton removeFromSuperview];
  }
  // NSLog(@"map row %@",tableRow);
 // NSIndexPath *path = [NSIndexPath indexPathForRow:[tableRow integerValue] inSection:0];
 // NSManagedObject *managedObject = [self.dataFetchedResultsController objectAtIndexPath:path];
  NSString * fullAddressString = [NSString stringWithFormat:@"Ukraine, %@, %@, %@",self.singleOrganization.region,self.singleOrganization.city,self.singleOrganization.address];
  // NSLog(@"map row %@",fullAddressString);
  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  [geocoder geocodeAddressString:fullAddressString completionHandler:^(NSArray *placemarks, NSError *error) {
    if (error != nil)
    {
       NSLog(@"Geocode failed with error: %@", error);
     // [self displayError:error];
      return;
    }
    CLPlacemark *placemark = (CLPlacemark *)placemarks[0];
    RRRMapViewController * locationViewController = [RRRMapViewController new];
    locationViewController.location = placemark.location; //(__bridge CLLocationCoordinate2D *)(placemark.location);
    [self.navigationController pushViewController:locationViewController animated:YES];
    //    NSString *ll = [NSString stringWithFormat:@"%f,%f",
    //                    placemark.location.coordinate.latitude,
    //                    placemark.location.coordinate.longitude];
    //    ll = [ll stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    //    NSString *url = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", ll];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
  }];
}

- (void)buttonCallPressed:(NSNumber *)tableRow {
  //NSIndexPath *path = [NSIndexPath indexPathForRow:[tableRow integerValue] inSection:0];
 // NSManagedObject *managedObject = [self.dataFetchedResultsController objectAtIndexPath:path];
  
  NSString *cleanedString = [[self.singleOrganization.phone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
  NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:+38%@", cleanedString]];
#warning uncomment to make a call
  // [[UIApplication sharedApplication] openURL:telURL];
  NSLog(@"calling to %@",telURL);
}

#pragma mark - other

- (void)navBarShareButtonPressed {
  NSLog(@"share");
}



@end

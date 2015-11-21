//
//  RRRBaseTableViewController.m
//  ConverterLab
//
//  Created by Roman R on 21.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRBaseTableViewController.h"

@implementation RRRBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table Cell Buttons delegate

- (void)buttonURLPressed:(NSString *)link {
  NSURL *url = [NSURL URLWithString:link];
  [[UIApplication sharedApplication] openURL:url];
}

- (void)buttonMapPressed:(RRRSingleOrganization *)aSingleOrganization {
    NSString * fullAddressString = [NSString stringWithFormat:@"Ukraine, %@, %@, %@",aSingleOrganization.region,aSingleOrganization.city,aSingleOrganization.address];
  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  [geocoder geocodeAddressString:fullAddressString completionHandler:^(NSArray *placemarks, NSError *error) {
    if (error != nil)  {
      [self displayError:[NSString stringWithFormat:@"Geocode failed with error: %@", error]];
      return;
    }
    CLPlacemark *placemark = (CLPlacemark *)placemarks[0];
    RRRMapViewController * locationViewController = [[RRRMapViewController alloc] initWithLocation:placemark.location];
    locationViewController.title = aSingleOrganization.title;
    [self.navigationController pushViewController:locationViewController animated:YES];
  }];
}

- (void)buttonCallPressed:(NSString *)phone {
  NSString *cleanedString = [[phone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
  NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:+38%@", cleanedString]];
  [self displayError:[NSString stringWithFormat:@"Simulator can't call on \n%@", telURL]];
}

#pragma mark - other

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

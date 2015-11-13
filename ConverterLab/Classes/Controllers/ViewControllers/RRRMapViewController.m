//
//  RRRMapViewController.m
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRMapViewController.h"

@interface RRRMapViewController ()

@end

@implementation RRRMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.mapView = [[MKMapView alloc] init];
  self.mapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
  self.mapView.delegate = self;
 // MKCoordinateRegionMakeWithDistance(self.location.coordinate, 1500, 1500);
  [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.location.coordinate, 1000, 1000)];
  [self.view addSubview:self.mapView];
  RRRAnnotation * pin = [RRRAnnotation new];
  pin.coordinate = self.location.coordinate;
  self.mapView.showsUserLocation =  NO;
  [self.mapView addAnnotation:pin];
  [self.mapView setCenterCoordinate:pin.coordinate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

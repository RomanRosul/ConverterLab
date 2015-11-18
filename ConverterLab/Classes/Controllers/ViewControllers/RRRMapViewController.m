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
  self.mapView.frame = [[UIScreen mainScreen]bounds];
  //CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
  self.mapView.delegate = self;
  [self.view addSubview:self.mapView];
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.location.coordinate, 500, 500);
  RRRAnnotation * pin = [RRRAnnotation new];
  pin.coordinate = self.location.coordinate;
  [self.mapView addAnnotation:pin];
  [self.mapView setRegion:region animated:YES];
  [self.mapView regionThatFits:region]; }

@end

//
//  RRRMapViewController.m
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRMapViewController.h"

@interface RRRMapViewController ()
@property (strong,nonatomic) MKMapView * mapView;
@property (nonatomic) CLLocation * location;
@end

@implementation RRRMapViewController

-(instancetype)initWithLocation:(CLLocation *)aLocation {
  self = [super init];
  if (self)
  {
    self.location = aLocation;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.mapView = [[MKMapView alloc] init];
  self.mapView.frame = [[UIScreen mainScreen]bounds];
  [self.mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];  
  self.mapView.delegate = self;
  [self.view addSubview:self.mapView];
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.location.coordinate, 500, 500);
  RRRAnnotation * pin = [RRRAnnotation new];
  pin.coordinate = self.location.coordinate;
  [self.mapView addAnnotation:pin];
  [self.mapView setRegion:region animated:YES];
  [self.mapView regionThatFits:region];
}

@end

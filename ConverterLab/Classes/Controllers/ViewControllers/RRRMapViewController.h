//
//  RRRMapViewController.h
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RRRAnnotation.h"

@interface RRRMapViewController : UIViewController <MKMapViewDelegate>
@property (strong,nonatomic) MKMapView * mapView;
@property (nonatomic) CLLocation * location;

@end

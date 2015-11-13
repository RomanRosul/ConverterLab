//
//  RRRAnnotation.h
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RRRAnnotation : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D  coordinate;

@end

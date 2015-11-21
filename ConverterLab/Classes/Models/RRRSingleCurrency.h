//
//  RRRSingleCurrency.h
//  ConverterLab
//
//  Created by Roman R on 12.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRRSingleCurrency : NSCoder

@property (strong,nonatomic) NSString * localizedTitle;
@property (strong,nonatomic) NSString * keyTitle;
@property (strong,nonatomic) NSNumber * ask;
@property (strong,nonatomic) NSNumber * bid; 

@end

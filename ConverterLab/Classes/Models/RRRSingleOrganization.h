//
//  RRRSingleOrganization.h
//  ConverterLab
//
//  Created by Roman R on 12.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRRSingleCurrency.h"

@interface RRRSingleOrganization : NSObject

@property (strong,nonatomic) NSString * title;
//@property (strong,nonatomic) NSString * type;
@property (strong,nonatomic) NSString * region;
@property (strong,nonatomic) NSString * city;
@property (strong,nonatomic) NSString * address;
@property (strong,nonatomic) NSString * phone;
//@property (strong,nonatomic) NSString * email;
@property (strong,nonatomic) NSString * link;
@property (strong,nonatomic) NSString * coord;
//@property (strong,nonatomic) NSString * detailedInfo;
@property (strong,nonatomic) NSMutableArray * currencies;

@end

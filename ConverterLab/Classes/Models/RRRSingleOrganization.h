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
@property (strong,nonatomic) NSString * region;
@property (strong,nonatomic) NSString * city;
@property (strong,nonatomic) NSString * address;
@property (strong,nonatomic) NSString * phone;
@property (strong,nonatomic) NSString * link;
@property (strong,nonatomic) NSMutableArray * currencies;

-(instancetype)initWithTitle:(NSString *)aTitle
                  withRegion:(NSString *)aRegion
                    withCity:(NSString *)aCity
                 withAddress:(NSString *)aAddress
                   withPhone:(NSString *)aPhone
                    withLink:(NSString *)aLink
              withCurrencies:(NSMutableArray *)aCurrencies;

@end

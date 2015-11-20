//
//  RRRSingleOrganization.m
//  ConverterLab
//
//  Created by Roman R on 12.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRSingleOrganization.h"

@implementation RRRSingleOrganization

-(instancetype)init
{
  self = [super init];
  if (self)
  {
    self.currencies = [[NSMutableArray alloc] init];
  }
  return self;
}

-(instancetype)initWithTitle:(NSString *)aTitle
                  withRegion:(NSString *)aRegion
                    withCity:(NSString *)aCity
                 withAddress:(NSString *)aAddress
                   withPhone:(NSString *)aPhone
                    withLink:(NSString *)aLink
              withCurrencies:(NSMutableArray *)aCurrencies
{
  self = [super init];
  if (self)
  {
    self.title = aTitle;
    self.region = aRegion;
    self.city = aCity;
    self.address = aAddress;
    self.phone = aPhone;
    self.link = aLink;
    self.currencies = aCurrencies;
  }
  return self;
}

-(NSString *)description {
  return [NSString stringWithFormat:@"%@,%@,%@",self.title, self.address, [self.currencies description]];
}

@end

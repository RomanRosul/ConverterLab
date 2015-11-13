//
//  RRRSingleCurrency.m
//  ConverterLab
//
//  Created by Roman R on 12.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRSingleCurrency.h"

@implementation RRRSingleCurrency

- (void)encodeWithCoder:(NSCoder *)aCoder{
  [aCoder encodeObject:self.localizedTitle forKey:@"localizedTitle"];
  [aCoder encodeObject:self.keyTitle forKey:@"keyTitle"];
  [aCoder encodeObject:self.ask forKey:@"ask"];
  [aCoder encodeObject:self.bid forKey:@"bid"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
  if(self = [super init]){
    self.localizedTitle = [aDecoder decodeObjectForKey:@"localizedTitle"];
    self.keyTitle = [aDecoder decodeObjectForKey:@"keyTitle"];
    self.ask = [aDecoder decodeObjectForKey:@"ask"];
    self.bid = [aDecoder decodeObjectForKey:@"bid"];
  }
  return self;
}

@end

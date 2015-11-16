//
//  RRRNetworkManager.m
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import "RRRNetworkManager.h"
#import "RRRDataBaseManager.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"



@interface RRRNetworkManager ()
@property (strong, nonatomic) NSArray *newsItems;
@end

@implementation RRRNetworkManager

-(instancetype)init
{
  self = [super init];
  if (self)
  {
    self.dataSourceUrl = [NSURL URLWithString:@"http://resources.finance.ua/ru/public/currency-cash.json"];
    self.delegateInstance = [RRRDataBaseManager sharedDBManager];
  }
  return self;
}

+ (instancetype)sharedNetworkManager
{
  static id sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}


- (BOOL) refreshDataSourceFromWeb {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  __block BOOL httpSuccess = NO;
  [manager GET:[self.dataSourceUrl absoluteString]
    parameters:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
         NSDictionary * responseDictionary  = (NSMutableDictionary *)responseObject;
         
         SEL selector = @selector(webDataSourceDidUpdated:);
         if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
         {
           [self.delegateInstance performSelector:selector withObject:responseDictionary];
         }
         httpSuccess =  YES;
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
         
//         SEL selector = @selector(webDataSourceNotUpdated);
//         if (self.delegateInstance && [self.delegateInstance respondsToSelector:selector])
//         {
//           [self.delegateInstance performSelector:selector];
//         }         
       }];
  return httpSuccess;
 }

@end

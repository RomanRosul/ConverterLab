//
//  RRRNetworkManager.h
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FetchedWebDataDelegate <NSObject>
@required
- (void)webDataSourceDidUpdated:(NSDictionary *)fetchedData;
@optional
- (void)webDataSourceNotUpdated;
@end

@interface RRRNetworkManager : NSObject
@property (nonatomic, weak) id <FetchedWebDataDelegate> delegateInstance;
+ (instancetype)sharedNetworkManager;
- (BOOL) refreshDataSourceFromWeb;
@end

//
//  RRRNetworkManager.h
//  ConverterLab
//
//  Created by Roman R on 11.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol fetchedDataDelegate <NSObject>
@required
- (void)dataSourceDidUpdated:(NSDictionary *)fetchedData;
@end


typedef void (^operationCompleteBlock) (BOOL success, NSDictionary * result);

@interface RRRNetworkManager : NSObject
@property (nonatomic) NSURL * dataSourceUrl;
@property (nonatomic, weak) id <fetchedDataDelegate> delegateInstance;
- (void) log;
@end

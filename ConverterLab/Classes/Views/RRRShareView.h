//
//  RRRShareView.h
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRSingleOrganization.h"

@interface RRRShareView : UIView

@property (strong,nonatomic) RRRSingleOrganization * singleOrganization;

- (instancetype) initWithFrame:(CGRect)frame  andData: (RRRSingleOrganization *)aSingleOrganization;

@end

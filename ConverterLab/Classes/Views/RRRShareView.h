//
//  RRRShareView.h
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRSingleOrganization.h"
#import "UIView+showHide.h"

@protocol ShareButtonDelegate <NSObject>
@required
- (void)ShareDidPressed;
@end

@interface RRRShareView : UIView <UITableViewDataSource>
@property (nonatomic, weak) id <ShareButtonDelegate> delegateInstance;
- (instancetype) initWithFrame:(CGRect)frame  andData: (RRRSingleOrganization *)aSingleOrganization;
@end

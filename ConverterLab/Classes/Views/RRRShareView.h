//
//  RRRShareView.h
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRSingleOrganization.h"

@protocol ShareButtonDelegate <NSObject>
@required
- (void)ShareDidPressed;
@end

@interface RRRShareView : UIView <UITableViewDataSource>

@property (strong,nonatomic) RRRSingleOrganization * singleOrganization;
@property (nonatomic, weak) id <ShareButtonDelegate> delegateInstance;
//@property (nonatomic, strong) UITableView * currenciesTable;

- (instancetype) initWithFrame:(CGRect)frame  andData: (RRRSingleOrganization *)aSingleOrganization;

@end

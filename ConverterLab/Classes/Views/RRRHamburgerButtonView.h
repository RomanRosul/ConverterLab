//
//  RRRHamburgerView.h
//  ConverterLab
//
//  Created by Roman R on 14.11.15.
//  Copyright © 2015 iOS_courses_FinalTask. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HamburgerButtonDelegate <NSObject>
@required
- (void)hamburgerDidPressed;
@end

@interface RRRHamburgerButtonView : UIButton

@property (nonatomic, weak) id <HamburgerButtonDelegate> delegateInstance;

@end

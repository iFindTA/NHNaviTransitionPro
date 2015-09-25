//
//  NHInteractiveTransition.h
//  NHNaviTransitionPro
//
//  Created by hu jiaju on 15/9/25.
//  Copyright © 2015年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController*)viewController;

@end

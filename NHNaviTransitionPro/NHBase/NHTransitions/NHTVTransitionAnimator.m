//
//  NHTVTransitionAnimator.m
//  NHNaviTransitionPro
//
//  Created by hu jiaju on 16/3/17.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NHBaseVCR.h"
#import "NHTVTransitionAnimator.h"

@interface NHTVTransitionAnimator ()

@end

@implementation NHTVTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController* toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //    [UIView animateWithDuration:duration animations:^{
    //        fromViewController.view.alpha = 0.0;
    //    } completion:^(BOOL finished) {
    //        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    //    }];
    
    //tv close
    UIView *fromView = fromViewController.view;
    [UIView animateWithDuration:0.5 animations:^{
        fromView.transform = CGAffineTransformMakeScale(1, 0.005);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:duration delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fromView.alpha = 0.001;
            fromView.transform = CGAffineTransformMakeScale(0, 0);
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }];
}

@end

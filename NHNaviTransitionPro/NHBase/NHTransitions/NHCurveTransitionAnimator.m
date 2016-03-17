//
//  NHCurveTransitionAnimator.m
//  NHNaviTransitionPro
//
//  Created by hu jiaju on 16/3/17.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NHBaseVCR.h"
#import "NHCurveTransitionAnimator.h"

@interface NHCurveTransitionAnimator ()

@property (weak, nonatomic) id transitionContext;

@end

@implementation NHCurveTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    
    UIView *containerView = [transitionContext containerView];
    NHBaseVCR *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect originBounds = CGRectMake(500, 100, 100, 50);
    //UIView *triggerView = fromVC.triggerObject;
    if (fromVC.triggerObject) {
        originBounds = fromVC.triggerObject.frame;
    }
    
    [containerView addSubview:toVC.view];
    
    UIBezierPath *originPath = [UIBezierPath bezierPathWithOvalInRect:originBounds];
    CGPoint extremePoint = CGPointMake(originBounds.origin.x - 0, originBounds.origin.y - CGRectGetHeight(toVC.view.bounds));
    
    float radius = sqrtf(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y);
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(originBounds, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalPath.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(originPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
    animation.duration = [self transitionDuration:transitionContext];
    animation.delegate = self;
    [maskLayer addAnimation:animation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    //[[self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask removeFromSuperlayer];
}

@end

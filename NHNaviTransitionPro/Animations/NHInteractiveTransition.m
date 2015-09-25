//
//  NHInteractiveTransition.m
//  NHNaviTransitionPro
//
//  Created by hu jiaju on 15/9/25.
//  Copyright © 2015年 hu jiaju. All rights reserved.
//

#import "NHInteractiveTransition.h"

@interface NHInteractiveTransition ()

@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, assign) CGFloat startScale;
@property (nonatomic, strong) UIView *transitioningView;
@property (nonatomic, assign) id <UIViewControllerContextTransitioning> context;
@property (nonatomic, strong) UIViewController *presentingVC;
@property (nonatomic, strong) UIViewController *navigationVC;

@end

@implementation NHInteractiveTransition

-(void)wireToViewController:(UIViewController *)viewController
{
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            // 2. Calculate the percentage of guesture
            CGFloat fraction = translation.y / 400.0;
            //Limit it between 0 and 1
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.5);
            
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 3. Gesture over. Check if the transition should happen or not
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

- (void)pinchAttachToView:(UIView *)view {
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [view addGestureRecognizer:pinch];
}

-(void)handlePinch:(UIPinchGestureRecognizer *)pinch {
    CGFloat scale = pinch.scale;
    switch ((NSInteger)pinch.state) {
        case UIGestureRecognizerStateBegan: {
            _startScale = scale;
            self.interacting = YES;
            [self.navigationVC.navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat percent = (1.0 - scale/_startScale);
            [self updateInteractiveTransition:(percent <0.0) ? 0.0 : percent];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGFloat percent = (1.0 - scale/_startScale);
            BOOL cancelled = ([pinch velocity] <5.0 && percent == 0.3);
            if (cancelled) [self cancelInteractiveTransition];
            else [self finishInteractiveTransition];
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            CGFloat percent = (1.0 - scale/_startScale);
            BOOL cancelled = ([pinch velocity] <5.0 && percent == 0.3);
            if (cancelled) [self cancelInteractiveTransition];
            else [self finishInteractiveTransition];
            break;
        }
    }
}

-(void)startInteractiveTransition:(id)transitionContext {
    //Maintain reference to context
    _context = transitionContext;
    
    //Get references to view hierarchy
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //Insert 'to' view into hierarchy
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    //Save reference for view to be scaled
    _transitioningView = fromViewController.view;
}

-(void)updateWithPercent:(CGFloat)percent {
    CGFloat scale = fabsf(percent-1.0);
    _transitioningView.transform = CGAffineTransformMakeScale(scale, scale);
    [_context updateInteractiveTransition:percent];
}

-(void)end:(BOOL)cancelled {
//    if (cancelled) {
//        [UIView animateWithDuration:_completionSpeed animations:^{
//            _transitioningView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//        } completion:^(BOOL finished) {
//            [_context cancelInteractiveTransition];
//            [_context completeTransition:NO];
//        }];
//    } else {
//        [UIView animateWithDuration:_completionSpeed animations:^{
//            _transitioningView.transform = CGAffineTransformMakeScale(0.0, 0.0);
//        } completion:^(BOOL finished) {
//            [_context finishInteractiveTransition];
//            [_context completeTransition:YES];
//        }];
//    }
}

@end

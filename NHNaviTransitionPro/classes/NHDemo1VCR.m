//
//  NHDemo1VCR.m
//  NHNaviTransitionPro
//
//  Created by hu jiaju on 15/9/25.
//  Copyright © 2015年 hu jiaju. All rights reserved.
//

#import "NHDemo1VCR.h"

#pragma mark -- Transition Animator --

@interface PushAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@end

@interface PopAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@end

@implementation PushAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController* toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    
    toViewController.view.alpha = 0.0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

@implementation PopAnimator

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

@interface NHDemo1VCR ()<UINavigationControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, assign) BOOL closing;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation NHDemo1VCR

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.delegate = self;
    
    self.title = @"demo1";
    
    CGRect bounds = self.view.bounds;
    bounds.size.height -= 100;
    _scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor blueColor];
    _scrollView.contentSize = bounds.size;
    [self.view addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC{
    if (operation == UINavigationControllerOperationPush)
        return [[PushAnimator alloc] init];
    
    if (operation == UINavigationControllerOperationPop)
        return [[PopAnimator alloc] init];
    
    return nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CGFloat offset_y = scrollView.contentOffset.y ;
    NSLog(@"offset_y:%f",offset_y);
    _closing = offset_y > 40;
    if (_closing) {
        [self closeNavi];
    }
}

- (void)closeNavi{
    [self.navigationController popViewControllerAnimated:true];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

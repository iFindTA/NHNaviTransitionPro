//
//  NHBaseVCR.m
//  NHNaviTransitionPro
//
//  Created by hu jiaju on 16/3/17.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NHBaseVCR.h"

@interface NHBaseVCR ()<UINavigationControllerDelegate>

@end

@implementation NHBaseVCR

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    __weak typeof(&*self) weakSelf = self;
    self.navigationController.delegate = weakSelf;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        if (self.pushType == NHPushTypeCurve){
            return [[NHCurveTransitionAnimator alloc] init];
        }
    }else if (operation == UINavigationControllerOperationPop){
        if (self.popType == NHPopTypeTV) {
            return [[NHTVTransitionAnimator alloc] init];
        }else if (self.popType == NHPopTypeCurve){
            return [[NHCurveTransitionAnimator alloc] init];
        }
    }
    
    return nil;
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

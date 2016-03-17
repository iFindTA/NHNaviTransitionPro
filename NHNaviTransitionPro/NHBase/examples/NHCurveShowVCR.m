//
//  NHCurveShowVCR.m
//  NHNaviTransitionPro
//
//  Created by hu jiaju on 16/3/17.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NHCurveShowVCR.h"

@implementation NHCurveShowVCR

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    CGRect bounds = CGRectMake(100, 200, 200, 50);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = bounds;
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.triggerObject = btn;
}

- (void)testAction:(UIButton *)btn {
    NSLog(@"___%s___",__FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

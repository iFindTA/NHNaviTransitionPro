//
//  ViewController.m
//  NHNaviTransitionPro
//
//  Created by hu jiaju on 15/9/25.
//  Copyright © 2015年 hu jiaju. All rights reserved.
//

#import "ViewController.h"
#import "NHDemo1VCR.h"
#import "NHDemo2VCR.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"导航转场";
    
    CGRect infoRect = CGRectMake(100, 100, 100, 50);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = infoRect;
    btn.exclusiveTouch = true;
    [btn setTitle:@"demo1" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(demo1Event) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    infoRect.origin.y += 60;
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = infoRect;
    btn.exclusiveTouch = true;
    [btn setTitle:@"demo2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(demo2Event) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)demo1Event {
    
    NHDemo1VCR *demo1 = [[NHDemo1VCR alloc] init];
    [self.navigationController pushViewController:demo1 animated:true];
}

- (void)demo2Event {
    
    NHDemo2VCR *demo2 = [[NHDemo2VCR alloc] init];
    [self.navigationController pushViewController:demo2 animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

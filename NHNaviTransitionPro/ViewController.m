//
//  ViewController.m
//  NHNaviTransitionPro
//
//  Created by hu jiaju on 15/9/25.
//  Copyright © 2015年 hu jiaju. All rights reserved.
//

#import "ViewController.h"
#import "NHTVCloseVCR.h"
#import "NHCurveShowVCR.h"
#import "NHNoneTransitionVCR.h"
#import "NHInteractiveTransition.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nullable, nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NHInteractiveTransition *animateManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"导航转场";
    
    CGRect infoRect = self.view.bounds;
    _tableView = [[UITableView alloc] initWithFrame:infoRect style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _animateManager = [[NHInteractiveTransition alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.pushType = NHPushTypeNone;
}

#pragma mark == tableView delegate ==

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *title;
    if (indexPath.row == 0) {
        title = @"TV Close Pop Transition";
    }else if (indexPath.row == 1){
        title = @"Curve Show Push Transition";
    }else if (indexPath.row == 2){
        title = @"Curve Show/TV Close Transition";
    }else if (indexPath.row == 3){
        title = @"Curve Show/Close Transition";
    }else if (indexPath.row == 4){
        title = @"None Transition";
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [indexPath row];
    UIViewController *destVCR;
    if (index == 0) {
        NHTVCloseVCR *tvClose = [[NHTVCloseVCR alloc] init];
        tvClose.popType = NHPopTypeTV;
        destVCR = tvClose;
    }else if (index == 1){
        NHCurveShowVCR *curveShow = [[NHCurveShowVCR alloc] init];
        self.triggerObject = [tableView cellForRowAtIndexPath:indexPath];
        self.pushType = NHPushTypeCurve;
        destVCR = curveShow;
    }else if (index == 2){
        NHCurveShowVCR *curveShow = [[NHCurveShowVCR alloc] init];
        curveShow.popType = NHPopTypeTV;
        self.pushType = NHPushTypeCurve;
        destVCR = curveShow;
    }else if (index == 3){
        NHCurveShowVCR *curveShow = [[NHCurveShowVCR alloc] init];
        curveShow.popType = NHPopTypeCurve;
        self.pushType = NHPushTypeCurve;
        destVCR = curveShow;
        //[_animateManager wireToViewController:curveShow];
    }else if (index == 4){
        NHNoneTransitionVCR *nonVCR = [[NHNoneTransitionVCR alloc] init];
        destVCR = nonVCR;
    }
    
    [self.navigationController pushViewController:destVCR animated:true];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

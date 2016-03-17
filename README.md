# NHNaviTransitionPro
###导航转场动画（for iOS）:TV关闭、曲面push

![GIF](https://github.com/iFindTA/screenshots/blob/master/trasition.gif)

#### Usage
```ObjectiveC
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
```
//
//  NHBaseVCR.h
//  NHNaviTransitionPro
//
//  Created by hu jiaju on 16/3/17.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHTransitions.h"

typedef enum {
    NHPushTypeNone             = 1 << 0,
    NHPushTypeCurve            = 1 << 1
}NHPushType;

typedef enum {
    NHPopTypeNone              = 1 << 0,
    NHPopTypeTV                = 1 << 1,
    NHPopTypeCurve             = 1 << 2
}NHPopType;

@interface NHBaseVCR : UIViewController

/*!
 *  @brief 触发push or pop动画的视图类object
 */
@property (nonatomic, nullable, strong) UIView *triggerObject;

@property (assign)NHPushType pushType;
@property (assign)NHPopType popType;

@end

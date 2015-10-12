//
//  CKAlertControllerTransitionDelegate.m
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import "CKAlertControllerTransitionDelegate.h"
#import "CKAlertControllerTransitionController.h"

@implementation CKAlertControllerTransitionDelegate

+ (instancetype)defaultDelete
{
    static CKAlertControllerTransitionDelegate *delegate = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        delegate = [CKAlertControllerTransitionDelegate new];
    });
    
    return delegate;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    CKAlertControllerTransitionController *controller = [CKAlertControllerTransitionController defaultTransitionController];
    controller.type = CKBaseTransitionAnimationTypePresent;
    return controller;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    CKAlertControllerTransitionController *controller = [CKAlertControllerTransitionController defaultTransitionController];
    controller.type = CKBaseTransitionAnimationTypeDismiss;
    return controller;
}

@end

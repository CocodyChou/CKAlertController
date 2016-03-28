//
//  CKAlertController.h
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CKAlertActionStyle) {
    CKAlertActionStyleDefault = 0,
    CKAlertActionStyleCancel,
    CKAlertActionStyleDestructive,
    CKAlertActionStyleOK
};

typedef NS_ENUM(NSInteger, CKAlertControllerStyle) {
    CKAlertControllerStyleActionSheet = 0,
    CKAlertControllerStyleAlert
};

typedef NS_ENUM(NSInteger, CKAlertControllerUIStyle) {
    CKAlertControllerUIStyleWhite = 0,
    CKAlertControllerUIStyleBlack
};

@interface CKAlertAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(CKAlertActionStyle)style handler:(void (^ __nullable)(CKAlertAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) CKAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end

@interface CKAlertController : UIViewController

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(CKAlertControllerStyle)preferredStyle;
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(CKAlertControllerStyle)preferredStyle preferredUIStyle:(CKAlertControllerUIStyle)preferredUIStyle;

#pragma mark - Actions
- (void)addAction:(CKAlertAction *)action;
@property (nonatomic, readonly) NSArray<CKAlertAction *> *actions;
@property (nonatomic, strong, nullable) CKAlertAction *preferredAction;

#pragma mark - Textfields
- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler;
@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;

#pragma mark - CheckBox
@property (nullable, nonatomic, copy) NSString *checkBoxTitle;
- (BOOL)isCheckBoxChecked;

#pragma mark - Properties
@property (nullable, nonatomic, copy) NSString *alertTitle;
@property (nullable, nonatomic, copy) NSString *alertMessage;

@property (nonatomic, readonly) CKAlertControllerStyle preferredStyle;
@property (nonatomic, readonly) CKAlertControllerUIStyle preferredUIStyle;

@end

NS_ASSUME_NONNULL_END

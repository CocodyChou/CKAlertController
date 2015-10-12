//
//  CKAlertController.m
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import "CKAlertController.h"
#import "CKAlertControllerTransitionDelegate.h"
#import "CKAlertView.h"

@interface CKAlertAction ()

@property (strong, nonatomic) void(^handler)(CKAlertAction *);

@end

@implementation CKAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(CKAlertActionStyle)style handler:(void (^)(CKAlertAction * _Nonnull))handler
{
    CKAlertAction *action = [[CKAlertAction new] initActionWithTitle:title style:style handler:handler];
    return action;
}

- (instancetype)initActionWithTitle:(NSString *)title style:(CKAlertActionStyle)style handler:(void (^)(CKAlertAction * _Nonnull))handler
{
    _title = title;
    _style = style;
    _handler = handler;
    return self;
}

@end

#pragma mark - Alert Controller
@interface CKAlertController () <CKAlertViewDelegate>
{

}
@property (weak, nonatomic) IBOutlet CKAlertView *alertView;

@property (strong, nonatomic) NSMutableArray *ck_actions;
@property (strong, nonatomic) NSMutableArray *ck_textFields;
@property (strong, nonatomic) NSMutableArray *ck_textFieldHandles;

@end

@implementation CKAlertController

#pragma mark - Lift cycles

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(CKAlertControllerStyle)preferredStyle
{
    return [self alertControllerWithTitle:title message:message preferredStyle:preferredStyle preferredUIStyle:CKAlertControllerUIStyleBlack];
}

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(CKAlertControllerStyle)preferredStyle preferredUIStyle:(CKAlertControllerUIStyle)preferredUIStyle
{
    CKAlertController *alertCont = [UIStoryboard storyboardWithName:@"CKAlertController" bundle:nil].instantiateInitialViewController;
    
    alertCont = [alertCont initAlertControllerWithTitle:title message:message preferredStyle:preferredStyle preferredUIStyle:preferredUIStyle];
    
    return alertCont;
}

- (instancetype)initAlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(CKAlertControllerStyle)preferredStyle preferredUIStyle:(CKAlertControllerUIStyle)preferredUIStyle
{
    _preferredStyle = preferredStyle;
    _preferredUIStyle = preferredUIStyle;
    _alertTitle = title;
    _alertMessage = message;
    self.transitioningDelegate = [CKAlertControllerTransitionDelegate defaultDelete];
    self.modalPresentationStyle = UIModalPresentationCustom;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.alertView.actions = self.actions;
    self.alertView.textFieldHandles = self.ck_textFieldHandles;
    self.alertView.title = _alertTitle;
    self.alertView.message = _alertMessage;
    
    self.alertView.delegate = self;
    self.alertView.preferredUIStyle = self.preferredUIStyle;
    
    if (self.preferredUIStyle == CKAlertControllerUIStyleBlack) {

    }
    else
    {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AlertView delegate
- (void)alertViewDidSelectAction:(CKAlertAction *)action atIndex:(NSInteger)index
{
    [self dismissViewControllerAnimated:YES completion:^{
        void(^handler)(CKAlertAction *action) = [action valueForKey:@"handler"];
        if (handler) {
            handler(action);
        }
    }];
}

#pragma mark - Add items
- (void)addAction:(CKAlertAction *)action
{
    [self.ck_actions addObject:action];
    switch (_preferredStyle) {
        case CKAlertControllerStyleActionSheet:
        {
            
            break;
        }
        case CKAlertControllerStyleAlert:
        {
            self.alertView.actions = self.actions;
            break;
        }
        default:
            break;
    }
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField * _Nonnull))configurationHandler
{
    [self.ck_textFieldHandles addObject:configurationHandler];
    
    switch (_preferredStyle) {
        case CKAlertControllerStyleActionSheet:
        {
            
            break;
        }
        case CKAlertControllerStyleAlert:
        {
            self.alertView.textFieldHandles = self.ck_textFieldHandles;
            break;
        }
        default:
            break;
    }
}

#pragma mark - Actions
- (IBAction)tapDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - getters
- (NSMutableArray *)ck_actions
{
    if (!_ck_actions) {
        _ck_actions = [NSMutableArray array];
    }
    return _ck_actions;
}

- (NSMutableArray *)ck_textFields
{
    if (!_ck_textFields) {
        _ck_textFields = [NSMutableArray array];
    }
    return _ck_textFields;
}

- (NSMutableArray *)ck_textFieldHandles
{
    if (!_ck_textFieldHandles) {
        _ck_textFieldHandles = [NSMutableArray array];
    }
    return _ck_textFieldHandles;
}

- (NSArray<CKAlertAction *> *)actions
{
    return [self.ck_actions copy];
}

- (NSArray<UITextField *> *)textFields
{
    return [self.ck_textFields copy];
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

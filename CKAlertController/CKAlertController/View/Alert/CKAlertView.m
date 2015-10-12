//
//  CKAlertView.m
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import "CKAlertView.h"
#import "CKAlertTextFieldCell.h"
#import "CKAlertController.h"
#import "CKActionCell.h"
#import "CKAlertTitleView.h"

CGFloat const SpaceOfTop = 20.f;
CGFloat const SpaceOfBottom = 20.f;
CGFloat const HeightOfActionCell = 54.f;
CGFloat const HeightOfTextFieldCell = 35.f;

@interface CKAlertView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *ck_textFields;
@property (assign, nonatomic) CGFloat maxHeight;

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet CKAlertTitleView *titleView;
@property (weak, nonatomic) IBOutlet UICollectionView *textFieldsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *actionsCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfTitleScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfTitleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfTextFieldsCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfActionsCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfAlertView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceOfTitleAndTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceOfTextFieldAndAction;
@property (weak, nonatomic) IBOutlet UIView *lineBetweenTextFieldAndAction;

@property (assign, nonatomic, getter=isKeyboardHidden) BOOL keyboardHidden;

@end

@implementation CKAlertView

- (void)awakeFromNib
{
    [[NSBundle mainBundle] loadNibNamed:@"CKAlertView" owner:self options:nil];
    [self addSubview:self.contentView];
    
    // 最大高度，默认上线各留40
    self.maxHeight = [UIScreen mainScreen].bounds.size.height - SpaceOfTop - SpaceOfBottom;
    
    [self addContentViewContraints];
    
    [self initCollectionViews];
    
    [self registerKeyboardNotifications];
    
    [self configUI];
    
    self.keyboardHidden = YES;
}

- (void)registerKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// useless
- (void)registerTextFieldNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - Inits and layouts
- (void)initCollectionViews
{
    [self.actionsCollectionView registerNib:[UINib nibWithNibName:@"CKActionCell" bundle:nil] forCellWithReuseIdentifier:@"CKActionCell"];
    
    [self.textFieldsCollectionView registerNib:[UINib nibWithNibName:@"CKAlertTextFieldCell" bundle:nil] forCellWithReuseIdentifier:@"CKAlertTextFieldCell"];
}

- (void)configUI
{
    if (self.preferredUIStyle == CKAlertControllerUIStyleBlack) {
        self.backgroundImageView.image = [UIImage imageNamed:@"popupbox_bottomborder__black"];
        self.titleView.labelOfTitle.textColor = [UIColor whiteColor];
        self.titleView.labelOfDetail.textColor = [UIColor colorWithRed:150.f / 255 green:150.f / 255 blue:150.f / 255 alpha:1.0f];
        self.lineBetweenTextFieldAndAction.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.6f];
    }
    else
    {
        self.backgroundImageView.image = [UIImage imageNamed:@"popupbox_bottomborder"];
        self.titleView.labelOfTitle.textColor = [UIColor colorWithRed:60.f / 255 green:40.f / 255 blue:129.f / 255 alpha:1.0f];
        self.titleView.labelOfDetail.textColor =[UIColor colorWithRed:100.f / 255 green:100.f / 255 blue:100.f / 255 alpha:1.0f];
        self.lineBetweenTextFieldAndAction.backgroundColor = [UIColor colorWithRed:148.f / 255 green:148.f / 255 blue:149.f / 255 alpha:.2f];
    }
    self.backgroundImageView.image = [self.backgroundImageView.image stretchableImageWithLeftCapWidth:12 topCapHeight:12];
}

- (void)addContentViewContraints
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:0];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    [self addConstraints:@[top, bottom, left, right]];
}

- (void)calculateLayout
{
    // 计算 title 和 message 高度
    NSInteger heightOfTitleView = 20 + [self.title boundingRectWithSize:CGSizeMake(242, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleView.labelOfTitle.font} context:nil].size.height + 8 + [self.message boundingRectWithSize:CGSizeMake(242, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleView.labelOfDetail.font} context:nil].size.height + 8;
    self.heightOfTitleScrollView.constant = heightOfTitleView;
    self.titleScrollView.contentSize = CGSizeMake(self.titleScrollView.frame.size.width, heightOfTitleView);
    self.heightOfTitleView.constant = heightOfTitleView;
    
    // 计算输入框高度
    self.heightOfTextFieldsCollectionView.constant = self.textFieldHandles.count * HeightOfTextFieldCell;
    
    // 如果没有输入框，则输入框和 title 中间间距为 0
    self.spaceOfTitleAndTextField.constant = self.textFieldHandles.count == 0 ? 0 : 16;
    
    // 如果没有按钮，则按钮与输入框的间距为0
    self.spaceOfTextFieldAndAction.constant = self.actions.count == 0 ? 0 : 16;
    
    // 两个按钮，同一行摆放，高度为HeightOfActionCell，其他情况则是按钮数量乘以HeightOfActionCell
    self.heightOfActionsCollectionView.constant = self.actions.count == 2 ? HeightOfActionCell : self.actions.count * HeightOfActionCell;
    
    // alertView 的高度
    self.heightOfAlertView.constant = [self calculateTotalHeight];
    [self adaptLayout];
}

- (CGFloat)calculateTotalHeight
{
    // alertView 的高度
    return self.heightOfTitleScrollView.constant + self.spaceOfTitleAndTextField.constant + self.heightOfTextFieldsCollectionView.constant + self.spaceOfTextFieldAndAction.constant + self.heightOfActionsCollectionView.constant;
}

- (void)adaptLayout
{
    // 用 while 可以在 break之后继续执行方法内其他代码
    while (self.heightOfAlertView.constant > self.maxHeight) {
        // 记录原始高度
        CGFloat originHeightOfTextFieldCollectionView = self.heightOfTextFieldsCollectionView.constant;
        self.heightOfTextFieldsCollectionView.constant = self.actions.count >= 1 ? HeightOfTextFieldCell * 1.5 : self.textFieldHandles.count * HeightOfTextFieldCell;
        // 如果满足需要，则break
        if ([self calculateTotalHeight] <= self.maxHeight) {
            break;
        }
        // 不满足需要，首先还原 textFields 高度
        self.heightOfTextFieldsCollectionView.constant = originHeightOfTextFieldCollectionView;
        // 缩小 actions 高度
        self.heightOfActionsCollectionView.constant = self.actions.count >= 3 ? HeightOfActionCell * 2.2 : self.actions.count * HeightOfActionCell;
        
        // 如果满足需要，则break
        if ([self calculateTotalHeight] <= self.maxHeight) {
            break;
        }
        // 不满足需要，两部分都缩小
        self.heightOfTextFieldsCollectionView.constant = self.actions.count >= 1 ? HeightOfTextFieldCell * 1.5 : self.textFieldHandles.count * HeightOfTextFieldCell;
        
        self.heightOfActionsCollectionView.constant = self.actions.count >= 3 ? HeightOfActionCell * 2.2 : self.actions.count * HeightOfActionCell;
        // 如果满足需要，则break
        if ([self calculateTotalHeight] <= self.maxHeight) {
            break;
        }
        // 仍不满足需要，用最大高度减去各部位高度，设置给 title scrollView
        self.heightOfTitleScrollView.constant = self.maxHeight - self.heightOfActionsCollectionView.constant - self.heightOfTextFieldsCollectionView.constant - self.spaceOfTextFieldAndAction.constant - self.spaceOfTitleAndTextField.constant;
    }
    // 居中显示 alert view
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (constraint.firstItem == self && constraint.secondItem == self.superview && constraint.firstAttribute == NSLayoutAttributeCenterY) {
            if (self.isKeyboardHidden) {
                constraint.constant = 0;
            }
            else
            {
                constraint.constant = self.maxHeight / 2 - [UIScreen mainScreen].bounds.size.height / 2;
            }
            break;
        }
    }
    // 设置总体高度
    self.heightOfAlertView.constant = [self calculateTotalHeight] + 6 + 6;
}

#pragma mark - Collection View dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.actionsCollectionView]) {
        return self.actions.count;
    }
    else
    {
        return self.textFieldHandles.count;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:self.actionsCollectionView]) {
        CKActionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CKActionCell" forIndexPath:indexPath];
        
        CKAlertAction *action = self.actions[indexPath.row];
        cell.action = action;
        
        cell.preferredUIStyle = self.preferredUIStyle;
        
        if (self.preferredUIStyle == CKAlertControllerUIStyleBlack) {
            if (indexPath.row == 0) {
                cell.topLine.hidden = YES;
            }
            else
            {
                cell.topLine.hidden = NO;
                if (self.actions.count == 2) {
                    cell.leftLine.hidden = NO;
                }
            }
        }
        
        return cell;
    }
    else
    {
        CKAlertTextFieldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CKAlertTextFieldCell" forIndexPath:indexPath];
        
        void(^textFieldConfigurationBlock)(UITextField *textField) = self.textFieldHandles[indexPath.row];
        textFieldConfigurationBlock(cell.textField);
        
        if (indexPath.row == 0) {
            [cell.textField becomeFirstResponder];
        }
        
        if (self.ck_textFields.count <= indexPath.row) {
            [self.ck_textFields addObject:cell.textField];
        }
        else
        {
            self.ck_textFields[indexPath.row] = cell.textField;
        }
        
        cell.textField.delegate = self;
        cell.preferredUIStyle = self.preferredUIStyle;
        
        return cell;
    }
}

#pragma mark - Collection View delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if ([collectionView isEqual:self.actionsCollectionView]) {
        CKAlertAction *action = self.actions[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(alertViewDidSelectAction:atIndex:)]) {
            [self.delegate alertViewDidSelectAction:action atIndex:indexPath.row];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(collectionView.frame.size.width, HeightOfActionCell);
    if (self.actions.count == 2 && [collectionView isEqual:self.actionsCollectionView]) {
        size.width = collectionView.frame.size.width / 2;
    }
    if ([collectionView isEqual:self.textFieldsCollectionView]) {
        size.height = HeightOfTextFieldCell;
    }
    return size;
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger index = [self.textFields indexOfObject:textField];
    
    if (index == self.textFields.count - 1) {
        [textField resignFirstResponder];
    }
    else
    {
        [self.textFields[index + 1] becomeFirstResponder];
    }
    
    return YES;
}

#pragma mark - Notifications
- (void)keyboardWillShow:(NSNotification *)notification
{
    
    self.keyboardHidden = NO;
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.superview convertRect:keyboardRect fromView:nil];
    
    // 键盘的动画时间，设定与其完全保持一致
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 键盘的动画是变速的，设定与其完全保持一致
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSUInteger animationCurve;
    [animationCurveObject getValue:&animationCurve];
    
    self.maxHeight = [UIScreen mainScreen].bounds.size.height - keyboardRect.size.height;
    [self adaptLayout];
    
    // 开始及执行动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    [self layoutIfNeeded];
    
    [UIView commitAnimations];
}
/*!
 *  @author CK
 *
 *  键盘消失时的处理，文本输入框回到页面底部。
 *
 *  @param notification 通知
 */
- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.keyboardHidden = YES;
    
    NSDictionary* userInfo = [notification userInfo];
    
    // 键盘的动画时间，设定与其完全保持一致
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 键盘的动画是变速的，设定与其完全保持一致
    NSValue *animationCurveObject =[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSUInteger animationCurve;
    [animationCurveObject getValue:&animationCurve];
    
    self.maxHeight = [UIScreen mainScreen].bounds.size.height - SpaceOfTop - SpaceOfBottom;
    [self calculateLayout];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    [self layoutIfNeeded];
    
    [UIView commitAnimations];
}

- (void)textFieldTextDidChange:(NSNotification *)notification
{
    
}

#pragma mark - Setters
- (void)setActions:(NSArray *)actions
{
    _actions = actions;
    [self.actionsCollectionView reloadData];
    [self calculateLayout];
}

- (void)setTextFieldHandles:(NSArray *)textFieldHandles
{
    _textFieldHandles = textFieldHandles;
    [self.textFieldsCollectionView reloadData];
    [self calculateLayout];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.titleView.labelOfTitle.text = title;
    [self calculateLayout];
}

- (void)setMessage:(NSString *)message
{
    _message = [message copy];
    self.titleView.labelOfDetail.text = message;
    [self calculateLayout];
}

- (void)setPreferredUIStyle:(CKAlertControllerUIStyle)preferredUIStyle
{
    _preferredUIStyle = preferredUIStyle;
    [self configUI];
}

#pragma mark - Getters
- (NSMutableArray *)ck_textFields
{
    if (!_ck_textFields) {
        _ck_textFields = [NSMutableArray array];
    }
    return _ck_textFields;
}

- (NSArray *)textFields
{
    return [self.ck_textFields copy];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

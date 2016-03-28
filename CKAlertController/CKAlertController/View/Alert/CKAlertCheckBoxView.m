//
//  CKAlertCheckBoxView.m
//  Sensor2
//
//  Created by 仇弘扬 on 16/2/29.
//  Copyright © 2016年 xw. All rights reserved.
//

#import "CKAlertCheckBoxView.h"

@implementation CKAlertCheckBoxView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSBundle mainBundle] loadNibNamed:@"CKAlertCheckBoxView" owner:self options:nil];
    [self addSubview:self.contentView];
    
    [self.buttonOfCheckBox setImage:[UIImage imageNamed:@"btn_tanchukuang_weigouxuan"] forState:UIControlStateNormal];
    [self.buttonOfCheckBox setImage:[UIImage imageNamed:@"btn_tanchukuang_gouxuan"] forState:UIControlStateSelected];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCheck:)];
    [self addGestureRecognizer:tap];
    
#ifdef Sensor
    [self prepareForTheme];
#endif
}

#ifdef Sensor
- (void)prepareForTheme__black
{
    self.labelOfTip.textColor = AppThirdClassColor_200;
}

- (void)prepareForTheme__white
{
    self.labelOfTip.textColor = AppGrayColor(100);
}
#endif

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}

- (IBAction)handleCheck:(id)sender {
    self.buttonOfCheckBox.selected = !self.buttonOfCheckBox.selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

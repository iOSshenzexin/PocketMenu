//
//  SettingViewController.m
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/6/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UIActionSheetDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.hidesBarsOnSwipe = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"选择头像"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

//修改UIActionSheet弹窗字体的颜色和大小
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    NSLog(@"%@",actionSheet.subviews);
    for (UIView *subViwe in actionSheet.subviews) {
        if ([subViwe isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)subViwe;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
        }
    }
}

@end

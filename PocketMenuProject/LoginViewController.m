//
//  LoginViewController.m
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/6/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)didClickRegister:(id)sender {
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftBarButtonItem];
    [self deleteBack];
}
- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}
- (void)addLeftBarButtonItem{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(-10, 0, 50, 44);
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

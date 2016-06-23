//
//  LeftViewController.m
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/6/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "LeftViewController.h"
#import "MainViewController.h"
#import "FoodViewController.h"
#import "BillViewController.h"
#import "PersonViewController.h"
#import "MessageViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "ShoppingViewController.h"
#import "AppDelegate.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *titles;
@property (nonatomic,copy) NSArray *icons;

@end

@implementation LeftViewController
- (IBAction)didClickShoppingCar:(id)sender {
    UINavigationController *menuController =(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
     ShoppingViewController *svc = [[ShoppingViewController alloc] init];
    svc.title = @"购物车";
    [menuController pushViewController:svc animated:YES];;
}

- (IBAction)didClickLoginBtn:(id)sender {
    UINavigationController *menuController =(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
     LoginViewController *lvc = [[LoginViewController alloc] init];
    UINavigationController *nlvc = [[UINavigationController alloc] initWithRootViewController:lvc];
    [menuController presentViewController:nlvc animated:YES completion:nil];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 50;
    self.titles = @[@"美食之旅",@"我的订单",@"个人中心",@"消息通知"];
   // self.icons = @

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    //cell.imageView.image =
    return cell;
}
/**
 * 抽屉页点击每行跳转页面
 */
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UINavigationController *menuController =(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    
    switch (indexPath.row) {
        case 0:{
            DDMenuController *menu = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
            [menu showRootController:YES];
            break;
        }
        case 1:{
            BillViewController *bvc = [[BillViewController alloc] init];
            bvc.title = self.titles[1];
            [menuController pushViewController:bvc animated:YES];
            break;}
        case 2:{
            PersonViewController *pvc = [[PersonViewController alloc] init];
            pvc.title = self.titles[2];
            [menuController pushViewController:pvc animated:YES];
            break;
        }
        case 3:{
            MessageViewController *mvc = [[MessageViewController alloc] init];
            mvc.title = self.titles[3];
            [menuController pushViewController:mvc animated:YES];
            break;
        }
        default:
            break;
    }
}



- (IBAction)didSettingClick:(id)sender {
     UINavigationController *menuController =(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    SettingViewController *svc = [[SettingViewController alloc] init];
    svc.title = @"设置";
    [menuController pushViewController:svc animated:YES];
}
@end

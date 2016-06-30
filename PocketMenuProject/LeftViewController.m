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
#import "LECropPictureViewController.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,copy) NSArray *titles;
@property (nonatomic,copy) NSArray *icons;

@end

@implementation LeftViewController

- (IBAction)didClickShoppingCar:(id)sender {
     ShoppingViewController *svc = [[ShoppingViewController alloc] init];
    svc.title = @"购物车";
    [self.mainNavigationController pushViewController:svc animated:YES];;
}

- (IBAction)didClickLoginBtn:(id)sender {
     LoginViewController *lvc = [[LoginViewController alloc] init];
    UINavigationController *nlvc = [[UINavigationController alloc] initWithRootViewController:lvc];
    [self.mainNavigationController presentViewController:nlvc animated:YES completion:nil];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
      UINavigationController *menuController =(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    self.mainNavigationController = menuController;
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 50;
    self.headImage.userInteractionEnabled = YES;
    //给头像图片添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changHeadImage:)];
    [self.headImage addGestureRecognizer:tap];
    self.titles = @[@"美食之旅",@"我的订单",@"个人中心",@"消息通知"];

    //隐藏掉tableView多余的行
    // self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   // self.icons = @
}
/**
 *  头像图片上的点击事件
 */
- (void)changHeadImage:(UITapGestureRecognizer *)tap{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.mainNavigationController.view];
}

//修改UIActionSheet弹窗字体的颜色和大小
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    for (UIView *subViwe in actionSheet.subviews) {
        if ([subViwe isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)subViwe;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
        }
    }
}

#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    self.window = window;
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    if (buttonIndex == 2) return;
    if (buttonIndex == 0) {
        //调用相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您的照相机不可用或被您禁用了!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
    if (buttonIndex == 1){
        //调用相册
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:NO completion:nil];

//    [self.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
    LECropPictureViewController *cropPictureController = [[LECropPictureViewController alloc] initWithImage:image andCropPictureType:LECropPictureTypeRounded];
    cropPictureController.view.backgroundColor = [UIColor blackColor];
    cropPictureController.cropFrame = CGRectMake(50, 50, 250, 250);
    cropPictureController.borderColor = [UIColor grayColor];
    cropPictureController.borderWidth = 1.0;
    
    cropPictureController.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cropPictureController.photoAcceptedBlock = ^(UIImage *croppedPicture){
        self.headImage.image = croppedPicture;
        [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    };
    [self.window.rootViewController presentViewController:cropPictureController animated:YES completion:nil];

}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.titles[indexPath.row];
    //cell.imageView.image =
    return cell;
}
/**
 * 抽屉页点击每行跳转页面
 */
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            DDMenuController *menu = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
            [menu showRootController:YES];
            break;
        }
        case 1:{
            BillViewController *bvc = [[BillViewController alloc] init];
            bvc.title = self.titles[1];
            [self.mainNavigationController pushViewController:bvc animated:YES];
            break;}
        case 2:{
            PersonViewController *pvc = [[PersonViewController alloc] init];
            pvc.title = self.titles[2];
            [self.mainNavigationController pushViewController:pvc animated:YES];
            break;
        }
        case 3:{
            MessageViewController *mvc = [[MessageViewController alloc] init];
            mvc.title = self.titles[3];
            [self.mainNavigationController pushViewController:mvc animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark 解决cell分割线不能从头开始

-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView  setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView  respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView  setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark tableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIImageView *adImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height - 240)];
    adImage.image = [UIImage imageNamed:@"ad"];
    return adImage;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  60;
}

- (IBAction)didSettingClick:(id)sender {
     SettingViewController *svc = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"setting"];
    svc.title = @"设置";
    [self.mainNavigationController pushViewController:svc animated:YES];
}
@end

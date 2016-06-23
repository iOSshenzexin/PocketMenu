//
//  LeftViewController.h
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/6/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UINavigationController *mainNavigationController;
@property (nonatomic,weak) UIWindow *window;
- (IBAction)didSettingClick:(id)sender;

@end

//
//  PickupAreaController.m
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/7/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "PickupAreaController.h"
#import "SpecificBusinessController.h"
@interface PickupAreaController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PickupAreaController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickUpTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = @"商家名称:船歌鱼舫水饺";
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpecificBusinessController *sbc = [[SpecificBusinessController alloc] init];
    sbc.title = @"具体商家";
    [self.navigationController pushViewController:sbc animated:YES];
}

@end

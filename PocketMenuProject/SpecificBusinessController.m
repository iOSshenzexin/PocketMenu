//
//  SpecificBusinessController.m
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/7/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "SpecificBusinessController.h"

#import "LeftSelectScroll.h"

@interface SpecificBusinessController ()<LeftSelectScrollDelegate,UITableViewDataSource,UITableViewDelegate>{
    LeftSelectScroll *leftScrollView;
    
    NSMutableArray *leftDataSource;
    
    //当点击的时候 不去调用滑动调节
    BOOL isScrollSetSelect;
    
    UITableView *tableViewList;
    
}
@end

@implementation SpecificBusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObjects];
    
    [self creatLeftScrollView];
    
    [self createTableView];
    
}

-(void)initObjects{
    leftDataSource = [[NSMutableArray alloc]initWithObjects:@"套餐1",@"套餐2",@"套餐3",@"套餐4",@"套餐1",@"套餐2",@"套餐3",@"套餐4",@"套餐1",@"套餐2",@"套餐3",@"套餐4", nil];
    
}

-(void)createTableView{
    tableViewList = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftScrollView.frame), leftScrollY, kScreenWidth*0.75, kScreenHeight-(kTabbar_H)-leftScrollY)];
    tableViewList.delegate = self;
    tableViewList.dataSource = self;
    tableViewList.tag = 21;//标识tableView
    [self.view addSubview:tableViewList];
    tableViewList.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableViewList.scrollEnabled = YES;
}

-(void)creatLeftScrollView{
    leftScrollView = [[LeftSelectScroll alloc]initWithFrame:CGRectMake(0, leftScrollY, kScreenWidth*0.25, kScreenHeight-(kTabbar_H)-leftScrollY)];
    
    CGFloat btnH = 53;
    NSInteger count = leftDataSource.count;
    
    leftScrollView.contentSize = CGSizeMake( 0, btnH * count);
    
    leftScrollView.backgroundColor = [UIColor grayColor];
    
    [leftScrollView setLeftSelectArray:leftDataSource];
    
    leftScrollView.leftSelectDelegate = self;
    
    leftScrollView.delegate = self;
    
    [self.view addSubview:leftScrollView];
}

#pragma mark 点击左侧切换右侧的代理方法
-(void)clickLeftSelectScrollButton:(NSInteger)indexPath{
    
    isScrollSetSelect = NO;
    
    [tableViewList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 21) {
        if (isScrollSetSelect == YES) {
            [leftScrollView setSelectButtonWithIndexPathSection:section];
        }
        return [self viewForHeaderView:section];
    }else{
        return nil;
    }
}


//实际需要会修改
-(UIView*)viewForHeaderView:(NSInteger)parama{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    label.backgroundColor = [UIColor grayColor];
    if (leftDataSource.count != 0) {
        label.text = leftDataSource[parama];
        //        [NSString stringWithFormat:@"第%ld组",(long)parama];
    }
    return label;
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  leftDataSource.count ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCellIdentF"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCellIdentF"];
    }
    cell.backgroundColor = RGBA(150*(indexPath.section + 1 ), 50*(indexPath.section + 1 ) , 25*(indexPath.section + 1 ),1);
    cell.textLabel.text = [NSString stringWithFormat:@"菜品%ld",indexPath.row + 1];
    return cell;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isScrollSetSelect = YES ;
}



@end

//
//  BillViewController.m
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/6/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "BillViewController.h"
#import "XFSegementView.h"
@interface BillViewController ()<TouchLabelDelegate,UITableViewDelegate,UITableViewDataSource>{
    XFSegementView *_segementView;
}

@property (nonatomic,copy) NSArray *firstArray;
@property (nonatomic,copy) NSArray *secondArray;
@property (nonatomic,copy) NSArray *thridArray;
@property (nonatomic,copy) NSArray *fourthArray;
@property (nonatomic,weak) UITableView *tableView;

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstArray = @[@"lallala",@"lallala",@"lallala",@"lallala"];
    [self addTopSegmentControl];
}

- (void)addTopSegmentControl{
    _segementView = [[XFSegementView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, 40)];
    //    [segementView setBackgroundColor:[UIColor cyanColor]];
    //    [segementView setFrame:CGRectMake(0, 200, 320, 100)];
    _segementView.titleArray = @[@"进行中",@"待支付",@"已完成",@"优惠码"];
    
    //    segementView.scrollLineColor = [UIColor greenColor];
    [_segementView.scrollLine setBackgroundColor:[UIColor redColor]];
    _segementView.titleSelectedColor = [UIColor redColor];
    //    segementView.titleSelectedColor = [UIColor greenColor];
    _segementView.touchDelegate = self;
    //    segementView.haveNoRightLine = NO;
    [self.view addSubview:_segementView];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, ScreenW, ScreenH - 104) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)touchLabelWithIndex:(NSInteger)index{
    NSLog(@"我是第%ld个label",index);
    switch (index) {
        case 0:{
            self.firstArray = @[@"lallala",@"lallala",@"lallala",@"lallala"];
             break;
        }
        case 1:{
            self.firstArray = @[@"aaaaa",@"aaaaa",@"aaaaa"];
            break;
        }
        case 2:{
            self.firstArray = @[@"bbbb",@"aaaaa",@"bbb"];
            break;
        }
        case 3:{
            self.firstArray = @[@"ccccc",@"aaaaa",@"aaaaa",@"fffff"];
            break;
        }
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark UITableViewDateSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.firstArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = self.firstArray[indexPath.row];
    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//}

@end

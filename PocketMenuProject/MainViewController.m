//
//  MainViewController.m
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/6/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

/*  青岛裕龙大厦 120.467981,36.106652 */
#import "MainViewController.h"
#import "SearchViewController.h"
#import "AdvertiseViewController.h"
#import "MainTableViewCell.h"
#import "TopBannerTool.h"
#import "KNBannerView.h"
#import "PickupAreaController.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,KNBannerViewDelegate>{
    GMSMapView *_mapView;
}

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"美食之旅";
    //滑动的时候隐藏掉navigationbar
    //self.navigationController.hidesBarsOnSwipe = YES;
    //添加搜索框
    [self addSearchBtnAtNavigationbar];
    
    [self deleteBack];
   // [self createMapUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];
    [self registerMainTableViewCell];
    
    //设置主页的头部轮播图
    self.mainTableView.tableHeaderView.height = 180;
    //self.mainTableView.tableHeaderView = [TopBannerTool setupNetWorkBannerViewAtViewController:self];
    self.mainTableView.tableHeaderView = [TopBannerTool setupLocatioBannerViewAtViewController:self];
}

  //顶部轮播图Delegate
- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index{
    NSLog(@"%zd---%zd",bannerView.tag,index);
}


- (void)registerMainTableViewCell{
    UINib *nib = [UINib nibWithNibName:@"MainTableViewCell" bundle:nil];
    [self.mainTableView registerNib:nib forCellReuseIdentifier:@"cellId"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cellId";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

#pragma mark  点击广告进入详情页
 
- (void)pushToAd{
    AdvertiseViewController *adVc = [[AdvertiseViewController alloc] init];
    [self.navigationController pushViewController:adVc animated:YES];
}

- (void)addSearchBtnAtNavigationbar{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(pushSearchViewController:)];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)pushSearchViewController:(UIButton *)btn{
    SearchViewController *svc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}



- (void)createMapUI{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:36.106652 longitude:120.467981 zoom:16];
    _mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    _mapView.myLocationEnabled = YES;
    self.view = _mapView;
    
    //在地图上创建一个中心
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(36.106652, 120.467981);
    marker.title = @"悉尼";
    marker.snippet = @"澳大利亚";
    marker.map = _mapView;
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PickupAreaController *pac = [[PickupAreaController alloc] init];
    pac.title = @"配送专区";
    [self.navigationController pushViewController:pac animated:YES];
}

@end

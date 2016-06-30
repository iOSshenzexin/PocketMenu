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
@interface MainViewController (){
    GMSMapView *_mapView;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"美食之旅";
    //添加搜索框
    [self addSearchBtnAtNavigationbar];
    
    [self deleteBack];
   // [self createMapUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];
}

/**
 *  点击广告进入详情页
 */

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


@end

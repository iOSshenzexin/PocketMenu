//
//  SearchViewController.m
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/6/30.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "SearchViewController.h"
#import "ZXSearchBar.h"
@interface SearchViewController (){
    GMSMapView *_mapView;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [ZXSearchBar searchBar];
    [self createMapUI];
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
@end

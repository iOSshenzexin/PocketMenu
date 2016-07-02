//
//  TopBannerTool.h
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/7/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNBannerView.h"

@interface TopBannerTool : NSObject

+ (UIView *)setupNetWorkBannerViewAtViewController:(UIViewController<KNBannerViewDelegate> *)vc;

+ (UIView *)setupLocatioBannerViewAtViewController:(UIViewController<KNBannerViewDelegate> *)vc;
@end

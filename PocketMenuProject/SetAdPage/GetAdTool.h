//
//  GetAdTool.h
//  advertiseDemo
//
//  Created by 杨晓婧 on 16/6/30.
//  Copyright © 2016年 zhouhuanqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvertiseView.h"

@interface GetAdTool : NSObject
+ (NSString *)getFilePathWithImageName:(NSString *)imageName;
+ (BOOL)isFileExistWithFilePath:(NSString *)filePath;
+ (void)getAdvertisingImage;
@end

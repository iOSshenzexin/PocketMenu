//
//  ClearDash.h
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/6/24.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClearDash : NSObject

/**
 *  NSArray *paths = NSSearchPathForDirectorieslnDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"path:%@", path); // 缓存目录
 
    NSString *tmpStr = NSTempararyDirectory();
    NSLog(@"path: %@", path); // 只是临时使用的数据应该保存到<Application_Home>/tmp文件夹，但是iCloud不会备份这些文件。
 
    NSArray *paths = NSSearchPathForDirectorieslnDomains(NSLibraryDirectory, NSUserDomainMask, YES)；
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"path: %@", path); //可以重新下载或者重新生成的数据应该保存在<Application_Home>/Library/Caches目录下面 。比如新闻、地图使用的数据缓存文件和可下载的内容保存到这个文件夹中。

 */

- (float)folderSizeAtPath:(NSString *)folderPath;

-(void)clearCacheFlie;
@end

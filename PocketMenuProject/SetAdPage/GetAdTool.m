//
//  GetAdTool.m
//  advertiseDemo
//
//  Created by 杨晓婧 on 16/6/30.
//  Copyright © 2016年 zhouhuanqiang. All rights reserved.
//

#import "GetAdTool.h"
#import <UIKit/UIKit.h>
@implementation GetAdTool
/**
 *  根据图片名拼接文件路径
 */
+ (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}

/**
 *  判断文件是否存在
 */
+ (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

+ (void)getAdvertisingImage
{
    
    // TODO 请求广告接口
    
    // 这里原本采用美团的广告接口，现在了一些固定的图片url代替
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    // 获取图片名:43-130P5122Z60-50.jpg
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [GetAdTool getFilePathWithImageName:imageName];
    BOOL isExist = [GetAdTool isFileExistWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        
        [GetAdTool downloadAdImageWithUrl:imageUrl imageName:imageName];
        
    }
    
}

/**
 *  下载新图片
 */
+ (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [GetAdTool deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
+ (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

@end

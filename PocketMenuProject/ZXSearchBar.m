//
//  ZXSearchBar.m
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/6/30.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSearchBar.h"
#import "UIView+Extension.h"

@interface ZXSearchBar()

@property (nonatomic,weak) UIImageView *searchIcon;

@end
@implementation ZXSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(300, 30);
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入查询条件";
        //拉伸图片防止变形的处理方法: 或者 提前在Xcode上设置图片中间拉伸
        UIImage *image = [UIImage imageNamed:@"searchbar_textfield_background"];
        CGFloat top = image.size.height * 0.5;
        CGFloat left = image.size.width * 0.5;
        CGFloat bottom = image.size.height * 0.5;
        CGFloat right = image.size.width * 0.5;
        
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        // 拉伸图片
        UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
        
        self.background = newImage;
        // 通过init初始化的控件大多都没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        searchIcon.contentMode =  UIViewContentModeCenter;
        searchIcon.size = CGSizeMake(30, 30);
        self.searchIcon = searchIcon;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar{
    return [[self alloc] init];
}

@end

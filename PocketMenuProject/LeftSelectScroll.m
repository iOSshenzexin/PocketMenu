//
//  LeftSelectScroll.m
//  YiLeHelp
//
//  Created by ChenYi on 15/11/14.
//  Copyright © 2015年 JC. All rights reserved.
//

#import "LeftSelectScroll.h"

@implementation LeftSelectScroll
{
    UIButton *tempSelectButton;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        tempSelectButton = [[UIButton alloc]init];

    }
    return self;
}

-(void)setLeftSelectArray:(NSArray *)leftSelectArray{
    _leftSelectArray = leftSelectArray;
//    NSArray *array = @[@"套餐",@"饮料",@"点心",@"小菜"];
//    _leftSelectArray = array;
    
    for (int i = 0; i<_leftSelectArray.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 53*i, kScreenWidth*0.25, 53)];
        [button setTitle:_leftSelectArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [button setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, button.frame.size.height - 0.5, button.frame.size.width, 0.5)];
//        label.backgroundColor = MYCOLOR_LineColor;
        label.backgroundColor = [UIColor grayColor];
        
        [button addSubview:label];
        
        [self addSubview:button];
        
        [button addTarget:self action:@selector(clickLeftSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+11;
        if (i == 0) {
            [button setSelected:YES];
            [button setBackgroundColor:[UIColor orangeColor]];
            tempSelectButton = button;
        }
    }
}

-(void)clickLeftSelectButton:(UIButton*)button{
    
    [tempSelectButton setSelected:NO];
    [tempSelectButton setBackgroundColor:[UIColor whiteColor]];
    
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setSelected:YES];
    
    tempSelectButton = button;
    
    NSInteger tag = button.tag - 11;
    if (self.leftSelectDelegate && [self.leftSelectDelegate respondsToSelector:@selector(clickLeftSelectScrollButton:)]) {
        [self.leftSelectDelegate clickLeftSelectScrollButton:tag];
    }
}

-(void)setSelectButtonWithIndexPathSection:(NSInteger)indexPathSection{

    for (int i = 0; i< _leftSelectArray.count; i++) {
        NSInteger tag = i + 11 ;
        
        UIButton *btn = (UIButton*)[self viewWithTag:tag];
        if (btn.tag == indexPathSection + 11) {
            tempSelectButton = btn;
            [btn setSelected:YES];
            btn.backgroundColor = [UIColor orangeColor];
        }else{
            [btn setSelected:NO];
            btn.backgroundColor = [UIColor whiteColor];
        }
    }
    
}


@end

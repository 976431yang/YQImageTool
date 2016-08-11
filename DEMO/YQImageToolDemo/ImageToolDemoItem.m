//
//  ImageToolDemoItem.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "ImageToolDemoItem.h"

@interface ImageToolDemoItem ()

@end

@implementation ImageToolDemoItem


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.IMGV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                             self.frame.size.width,
                                                             self.frame.size.height-40)];
    self.IMGV.contentMode = UIViewContentModeScaleAspectFit;
    self.IMGV.backgroundColor = [UIColor colorWithWhite:0.737 alpha:1.000];
    
    [self addSubview:self.IMGV];
    
    
    self.titleStr = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                             self.frame.size.height-40,
                                                             self.frame.size.width,
                                                             40)];
    self.titleStr.font = [UIFont systemFontOfSize:15];
    self.titleStr.textAlignment = NSTextAlignmentCenter;
    self.titleStr.numberOfLines = 0;
    
    [self addSubview:self.titleStr];
    
    
    return self;
}

@end

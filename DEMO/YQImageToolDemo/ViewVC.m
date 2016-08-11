//
//  ViewVC.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "ViewVC.h"

@interface ViewVC ()

@end

@implementation ViewVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,
                                                           self.item1.IMGV.frame.size.width,
                                                           self.item1.IMGV.frame.size.width)];
    
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = 20;
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(view1.bounds.size.width/2,
                                                            view1.bounds.size.width/2,
                                                            view1.bounds.size.width/2-20,
                                                            view1.bounds.size.width/2-20)];
    
    view2.backgroundColor = [UIColor orangeColor];
    view2.layer.shadowOffset = CGSizeMake(5, 5);
    view2.layer.shadowColor = [UIColor blackColor].CGColor;
    view2.layer.shadowRadius = 10;
    view2.layer.shadowOpacity = 0.8;
    
    UIImageView *IMGV = [[UIImageView alloc]initWithFrame:CGRectMake(100,
                                                                     100,
                                                                     view1.bounds.size.width/2-50,
                                                                     view1.bounds.size.width/2-50)];
    IMGV.contentMode = UIViewContentModeScaleAspectFill;
    IMGV.image = self.normalIMG;
    
    [view1 addSubview:view2];
    [view1 addSubview:IMGV];


    [self.item1.IMGV addSubview:view1];
    self.item1.titleStr.text = @"原UIView(有叠层)";
    
    self.item2.IMGV.image = [YQImageTool imageWithUIView:view1];
    self.item2.titleStr.text = @"生成图片";
    
    self.item3.hidden = YES;
    
    self.item4.IMGV.hidden = YES;
    
    
}

@end

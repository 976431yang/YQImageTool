//
//  CutVC.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "CutVC.h"

@interface CutVC ()

@end

@implementation CutVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    self.item1.IMGV.image = self.bigIMG;
    self.item1.titleStr.text = @"原图";
    
    self.item2.IMGV.image = [YQImageTool cutImageWithImage:self.bigIMG
                                                   atPoint:CGPointMake(200,200)
                                                  withSize:CGSizeMake(1000, 1000)
                                           backgroundColor:[UIColor clearColor]];
    self.item2.titleStr.text = @"正常区域剪裁后";
    
    
    self.item3.IMGV.image = [YQImageTool cutImageWithImage:self.bigIMG
                                                   atPoint:CGPointMake(-400,
                                                                       -400)
                                                  withSize:CGSizeMake(1000, 1000)
                                           backgroundColor:[UIColor clearColor]];
    self.item3.titleStr.text = @"超范围区域剪裁后";
    
    self.item4.IMGV.image = [YQImageTool cutImageWithImage:self.bigIMG
                                                   atPoint:CGPointMake(-400,
                                                                       -400)
                                                  withSize:CGSizeMake(1000, 1000)
                                           backgroundColor:[UIColor yellowColor]];
    self.item4.titleStr.text = @"超范围区域剪裁,带背景色";
    
}

@end

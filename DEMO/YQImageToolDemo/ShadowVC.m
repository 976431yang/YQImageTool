//
//  ShadowVC.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "ShadowVC.h"

@interface ShadowVC ()

@end

@implementation ShadowVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    //先处理一下原图,让效果更明显
    UIImage *oldIMG = [YQImageTool getCornerImageAtOriginalImageCornerWithImage:self.normalIMG
                                                                  andCornerWith:80
                                                             andBackGroundColor:[UIColor clearColor]];
    
    
    self.item1.IMGV.image = oldIMG;
    self.item1.titleStr.text = @"原图";
    
    self.item2.IMGV.image = [YQImageTool creatShadowImageWithOriginalImage:oldIMG
                                                           andShadowOffset:CGSizeMake(0, 0)
                                                              andBlurWidth:30
                                                                  andAlpha:1
                                                                  andColor:[UIColor yellowColor]];
    self.item2.titleStr.text = @"带阴影(黄色阴影)(无偏移)(带模糊)";
    
    self.item3.IMGV.image = [YQImageTool creatShadowImageWithOriginalImage:oldIMG
                                                           andShadowOffset:CGSizeMake(30, 30)
                                                              andBlurWidth:20
                                                                  andAlpha:1
                                                                  andColor:[UIColor whiteColor]];
    self.item3.titleStr.text = @"带阴影(白色阴影)(往右下方偏移)(带模糊)";
    
    
    self.item4.IMGV.image = [YQImageTool creatShadowImageWithOriginalImage:oldIMG
                                                           andShadowOffset:CGSizeMake(-30, -30)
                                                              andBlurWidth:0
                                                                  andAlpha:0.8
                                                                  andColor:[UIColor darkGrayColor]];
    self.item4.titleStr.text = @"带阴影(深灰色阴影)(往左上方偏移)(不带模糊)";
    
    
}

@end

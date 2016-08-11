//
//  MaskVC.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "MaskVC.h"

@interface MaskVC ()

@end

@implementation MaskVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //先把分辨率调一遍
    UIImage *oldIMG = [YQImageTool getThumbImageWithImage:self.normalIMG
                                                  andSize:self.maskIMG.size
                                                    Scale:NO];
    
    self.item1.IMGV.image = oldIMG;
    self.item1.titleStr.text = @"原图";
    
    self.item2.IMGV.image = self.maskIMG;
    self.item2.titleStr.text = @"遮罩图";
    
    self.item3.IMGV.image = [YQImageTool creatImageWithMaskImage:self.maskIMG andBackimage:oldIMG];
    self.item3.titleStr.text = @"生成的图片";
    
    
    self.item4.hidden = YES;
    
    
}

@end

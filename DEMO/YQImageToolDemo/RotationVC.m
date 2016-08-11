//
//  RotationVC.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "RotationVC.h"

@interface RotationVC ()

@end

@implementation RotationVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    
    self.item1.IMGV.image = self.normalIMG;
    self.item1.titleStr.text = @"原图";
    
    self.item2.IMGV.image = [YQImageTool GetRotationImageWithImage:self.normalIMG Angle:45];
    self.item2.titleStr.text = @"旋转后的";
    
    self.item3.IMGV.image = [YQImageTool GetRotationImageWithImage:self.normalIMG Angle:90];
    self.item3.titleStr.text = @"旋转后的";
    
    
    self.item4.IMGV.image = [YQImageTool GetRotationImageWithImage:self.normalIMG Angle:120];
    self.item4.titleStr.text = @"旋转后的";
    
    
}

@end

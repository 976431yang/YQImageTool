//
//  ThumVC.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "ThumVC.h"

@interface ThumVC ()

@end

@implementation ThumVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    self.item1.IMGV.image = self.bigIMG;
    self.item1.titleStr.text = @"原图";
    
    self.item2.IMGV.image = [YQImageTool getThumbImageWithImage:self.bigIMG
                                                        andSize:self.item2.IMGV.frame.size
                                                          Scale:YES];
    self.item2.titleStr.text = @"参数Scale为YES";
    
    
    self.item3.IMGV.image = [YQImageTool getThumbImageWithImage:self.bigIMG
                                                        andSize:self.item3.IMGV.frame.size
                                                          Scale:NO];
    self.item3.titleStr.text = @"参数Scale为NO";
    
    self.item4.hidden = YES;
}

@end

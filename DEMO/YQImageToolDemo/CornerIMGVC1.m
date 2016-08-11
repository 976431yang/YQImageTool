//
//  CornerIMGVC1.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "CornerIMGVC1.h"

@interface CornerIMGVC1 ()

@end

@implementation CornerIMGVC1

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    self.item1.IMGV.image = self.normalIMG;
    self.item1.titleStr.text = @"原图";
    
    self.item2.IMGV.image = [YQImageTool getCornerImageAtOriginalImageCornerWithImage:self.normalIMG
                                                                        andCornerWith:80
                                                                   andBackGroundColor:[UIColor clearColor]];
    self.item2.titleStr.text = @"直接在原图四周生成圆角";
    
    
    self.item3.IMGV.image = [YQImageTool getCornerImageFillSize:self.item3.IMGV.bounds.size
                                                      WithImage:self.normalIMG
                                                  andCornerWith:40
                                             andBackGroundColor:[UIColor clearColor]];
    self.item3.titleStr.text = @"根据Size生成圆角图片，图片会自适应填充";
    
    self.item4.IMGV.image = [YQImageTool getCornerImageFitSize:self.item3.IMGV.bounds.size
                                                      WithImage:self.normalIMG
                                                  andCornerWith:40
                                             andBackGroundColor:[UIColor clearColor]];
    self.item4.titleStr.text = @"根据Size生成圆角图片，图片会拉伸-变形";

}


@end

//
//  FrontImageDemo.m
//  YQImageCompressorDemo
//
//  Created by problemchild on 16/8/9.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "FrontImageDemo.h"

@interface FrontImageDemo ()

@end

@implementation FrontImageDemo

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self compressImage];
}

-(void)compressImage{
    self.title = @"正在压缩..";
    
    UIImage *newIMG = [YQImageCompressTool CompressToImageWithImage:self.oldIMG
                                                           ShowSize:self.NewIMGSize
                                                           FileSize:200];
    
    NSData *newIMGData = UIImageJPEGRepresentation(newIMG,1);
    
    self.NewIMGV.image = newIMG;
    self.title = self.titleStr;
    
    [self alertResult:[NSString stringWithFormat:@"压缩得到的UIImage的大小： %lu kb",[newIMGData length]/1024]];
}



@end

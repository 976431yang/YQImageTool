//
//  FrontDataDemo.m
//  YQImageCompressorDemo
//
//  Created by problemchild on 16/8/9.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "FrontDataDemo.h"

@interface FrontDataDemo ()

@end

@implementation FrontDataDemo


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self compressImage];
}

-(void)compressImage{
    self.title = @"正在压缩..";
    
    NSData *newIMGData = [YQImageCompressTool CompressToDataWithImage:self.oldIMG
                                                             ShowSize:self.NewIMGSize
                                                             FileSize:200];
    UIImage *newIMG = [UIImage imageWithData:newIMGData];
    
    NSData *ReNewIMGData = UIImageJPEGRepresentation(newIMG,1);
    
    self.NewIMGV.image = newIMG;
    self.title = self.titleStr;
    
    [self alertResult:[NSString stringWithFormat:@"压缩得到的NSData大小：%lu kb\n\n使用Data再次创建的UIImage的大小： %lu kb",[newIMGData length]/1024,[ReNewIMGData length]/1024]];
}


@end

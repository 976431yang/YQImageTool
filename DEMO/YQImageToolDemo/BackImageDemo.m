//
//  BackImageDemo.m
//  YQImageCompressorDemo
//
//  Created by problemchild on 16/8/9.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "BackImageDemo.h"

@interface BackImageDemo ()

@end

@implementation BackImageDemo


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self compressImage];
}

-(void)compressImage{
    self.title = @"正在压缩..";
    
    [YQImageCompressTool CompressToImageAtBackgroundWithImage:self.oldIMG
                                                     ShowSize:self.NewIMGSize
                                                     FileSize:200
                                                        block:^(UIImage *resultImage)
    {
        NSData *newIMGData = UIImageJPEGRepresentation(resultImage,1);
        
        //获取主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.NewIMGV.image = resultImage;
            self.title = self.titleStr;
            
            [self alertResult:[NSString stringWithFormat:@"压缩得到的UIImage的大小： %lu kb",[newIMGData length]/1024]];
        });
    }];
}


@end

//
//  BackDataDemo.m
//  YQImageCompressorDemo
//
//  Created by problemchild on 16/8/9.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "BackDataDemo.h"

@interface BackDataDemo ()

@end

@implementation BackDataDemo

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self compressImage];
}

-(void)compressImage{
    self.title = @"正在压缩..";
    
    [YQImageCompressTool CompressToDataAtBackgroundWithImage:self.oldIMG
                                                    ShowSize:self.NewIMGSize
                                                    FileSize:200
                                                       block:^(NSData *resultData)
    {
        UIImage *newIMG = [UIImage imageWithData:resultData];
        
        NSData *newIMGData = UIImageJPEGRepresentation(newIMG,1);
        
        //获取主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.NewIMGV.image = newIMG;
            self.title = self.titleStr;
            
            [self alertResult:[NSString stringWithFormat:@"压缩得到的NSData大小：%lu kb\n\n使用Data再次创建的UIImage的大小： %lu kb",[resultData length]/1024,[newIMGData length]/1024]];
        });
        
    }];
}


@end

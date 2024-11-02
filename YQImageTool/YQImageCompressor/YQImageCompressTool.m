//
//  YQImageCompressTool.m
//  compressTest
//
//  Created by problemchild on 16/7/7.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "YQImageCompressTool.h"

@implementation YQImageCompressTool

#pragma mark --------前台压缩（可能比较慢，造成当前进程卡住）
//------压缩得到 目标大小的 图片Data
+ (NSData *)compressToDataWithImage:(UIImage *)oldImage
                           showSize:(CGSize)showSize
                           fileSize:(NSInteger)fileSize {
    NSLog(@"正在压缩图片...");
    UIImage *oldIMG = oldImage;
    
    UIImage *thumIMG = [self resizeImageWithImage:oldIMG
                                          andSize:showSize
                                            scale:NO];
    
    NSData  *outIMGData = [self onlyCompressToDataWithImage:thumIMG
                                                   fileSize:(fileSize * 1024)];
    
    CGSize scalesize = showSize;
    
    //如果压缩后还是无法达到文件大小，则降低分辨率，继续压缩
    while (outIMGData.length > (fileSize*1024)) {
        
        scalesize = CGSizeMake(scalesize.width * 0.8, scalesize.height * 0.8);
        
        thumIMG = [self resizeImageWithImage:oldIMG
                                     andSize:scalesize
                                       scale:NO];
        
        outIMGData = [self onlyCompressToDataWithImage:thumIMG
                                              fileSize:(fileSize*1024)];
    }
    NSLog(@"压缩完成");
    return outIMGData;
}

//------压缩得到 目标大小的 UIImage
+ (UIImage *)compressToImageWithImage:(UIImage *)oldImage
                             showSize:(CGSize)showSize
                             fileSize:(NSInteger)fileSize {
    NSLog(@"正在压缩图片...");
    UIImage *oldIMG = oldImage;
    
    UIImage *thumIMG = [self resizeImageWithImage:oldIMG
                                          andSize:showSize
                                            scale:NO];
    
    UIImage *outIMG = [self onlyCompressToImageWithImage:thumIMG
                                                fileSize:(fileSize * 1024)];
    
    NSData * newimageData = UIImageJPEGRepresentation(outIMG,1);
    CGSize scalesize = showSize;
    
    //如果压缩后还是无法达到文件大小，则降低分辨率，继续压缩
    while ([newimageData length] > (fileSize*1024)) {
        
        scalesize = CGSizeMake(scalesize.width * 0.8, scalesize.height * 0.8);
        
        thumIMG = [self resizeImageWithImage:outIMG
                                     andSize:scalesize
                                       scale:NO];
        
        outIMG = [self onlyCompressToImageWithImage:thumIMG
                                           fileSize:(fileSize * 1024)];
        
        newimageData = UIImageJPEGRepresentation(outIMG,1);
        
    }
    NSLog(@"压缩完成");
    return outIMG;
}


#pragma mark --------后台压缩（异步进行，不会卡住前台进程）

// 后台压缩得到 目标大小的 图片Data
+ (void)compressToDataAtBackgroundWithImage:(UIImage *)oldImage
                                   showSize:(CGSize)showSize
                                   fileSize:(NSInteger)fileSize
                                     block:(DataBlock)dataBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *newIMGData = [YQImageCompressTool compressToDataWithImage:oldImage
                                                                 showSize:showSize
                                                                 fileSize:fileSize];
        dataBlock(newIMGData);
    });
}



//后台压缩得到 目标大小的 UIImage
+ (void)compressToImageAtBackgroundWithImage:(UIImage *)oldImage
                                    showSize:(CGSize)showSize
                                    fileSize:(NSInteger)fileSize
                                       block:(ImgBlock)imgBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *newIMG = [YQImageCompressTool compressToImageWithImage:oldImage
                                                               showSize:showSize
                                                               fileSize:fileSize];
        imgBlock(newIMG);
    });
}


#pragma mark --------细化调用方法
//------只压不缩--返回UIImage
//优点：不影响分辨率，不太影响清晰度
//缺点：存在最小限制，可能压不到目标大小
+ (UIImage *)onlyCompressToImageWithImage:(UIImage *)oldImage
                                 fileSize:(NSInteger)fileSize {
    
    CGFloat compression    = 0.9f;
    CGFloat minCompression = 0.01f;
    NSData *imageData = UIImageJPEGRepresentation(oldImage,
                                                  compression);
    
    //每次减少的比例
    float scale = 0.1;
    
    //新UIImage的Data
    NSData * newimageData = UIImageJPEGRepresentation(oldImage, 1);
    
    //循环条件：没到最小压缩比例，且没压缩到目标大小
    while ((compression > minCompression) &&
           (newimageData.length > fileSize)) {
        imageData = UIImageJPEGRepresentation(oldImage, compression);
        UIImage *compressedImage = [UIImage imageWithData:imageData];
        newimageData= UIImageJPEGRepresentation(compressedImage, 1);
        
//        NSLog(@"%f,%lu",compression,(unsigned long)newimageData.length);
        
        compression -= scale;
    }
    UIImage *compressedImage = [UIImage imageWithData:newimageData];
    
//    NSLog(@"只压不缩-返回UIImage大小：%lu kb",((NSData *)UIImageJPEGRepresentation(compressedImage,1)).length/1024);
    return compressedImage;
}

//------只压不缩--按NSData大小压缩，返回NSData
+ (NSData *)onlyCompressToDataWithImage:(UIImage *)oldImage
                               fileSize:(NSInteger)fileSize {
    CGFloat compression    = 1.0f;
    CGFloat minCompression = 0.001f;
    NSData *imageData = UIImageJPEGRepresentation(oldImage, compression);
    //每次减少的比例
    float scale = 0.1;
    
    //循环条件：没到最小压缩比例，且没压缩到目标大小
    while ((compression > minCompression) &&
           (imageData.length > fileSize)) {
        compression -= scale;
        imageData = UIImageJPEGRepresentation(oldImage, compression);
        
//        NSLog(@"%f,%lu",compression,(unsigned long)imageData.length);
    }
    //NSLog(@"只压不缩-返回Data大小：%lu kb",imageData.length/1024);
    return imageData;
}



//------只缩不压
//若Scale为YES，则原图会根据Size进行拉伸-会变形
//若Scale为NO，则原图会根据Size进行填充-不会变形
+ (UIImage *)resizeImageWithImage:(UIImage *)oldImage
                          andSize:(CGSize)size
                            scale:(BOOL)scale {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    if (!scale) {
        
        CGFloat bili_imageWH = oldImage.size.width /
                               oldImage.size.height;
        CGFloat bili_SizeWH  = size.width / size.height;
        
        if (bili_imageWH > bili_SizeWH) {
            
            CGFloat bili_SizeH_imageH = size.height /
                                        oldImage.size.height;
            CGFloat height = oldImage.size.height * bili_SizeH_imageH;
            CGFloat width = height * bili_imageWH;
            CGFloat x = -(width - size.width) /2 ;
            CGFloat y = 0;
            rect = CGRectMake(x, y, width, height);
            
        } else {
            
            CGFloat bili_SizeW_imageW = size.width / oldImage.size.width;
            CGFloat width = oldImage.size.width *
                            bili_SizeW_imageW;
            CGFloat height = width / bili_imageWH;
            CGFloat x = 0;
            CGFloat y = -(height - size.height) / 2;
            rect = CGRectMake(x,y, width, height);
        }
    }
    
    [[UIColor clearColor] set];
    UIRectFill(rect);
    
    [oldImage drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}




@end

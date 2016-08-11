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
+(NSData *)CompressToDataWithImage:(UIImage *)OldImage
                          ShowSize:(CGSize)ShowSize
                          FileSize:(NSInteger)FileSize
{
    NSLog(@"正在压缩图片...");
    UIImage *oldIMG = OldImage;
    
    UIImage *thumIMG = [self ResizeImageWithImage:oldIMG
                                          andSize:ShowSize
                                            Scale:NO];
    
    NSData  *outIMGData = [self OnlyCompressToDataWithImage:thumIMG
                                               FileSize:(FileSize*1024)];
    
    CGSize scalesize = ShowSize;
    
    //如果压缩后还是无法达到文件大小，则降低分辨率，继续压缩
    while (outIMGData.length>(FileSize*1024)) {
        
        scalesize = CGSizeMake(scalesize.width*0.8, scalesize.height*0.8);
        
        thumIMG = [self ResizeImageWithImage:oldIMG
                                     andSize:scalesize
                                       Scale:NO];
        
        outIMGData = [self OnlyCompressToDataWithImage:thumIMG
                                              FileSize:(FileSize*1024)];
    }
    NSLog(@"压缩完成");
    return outIMGData;
}

//------压缩得到 目标大小的 UIImage
+(UIImage *)CompressToImageWithImage:(UIImage *)OldImage
                            ShowSize:(CGSize)ShowSize
                            FileSize:(NSInteger)FileSize
{
    NSLog(@"正在压缩图片...");
    UIImage *oldIMG = OldImage;
    
    UIImage *thumIMG = [self ResizeImageWithImage:oldIMG
                                          andSize:ShowSize
                                            Scale:NO];
    
    UIImage *outIMG = [self OnlyCompressToImageWithImage:thumIMG
                                                FileSize:(FileSize*1024)];
    
    NSData * newimageData = UIImageJPEGRepresentation(outIMG,1);
    CGSize scalesize = ShowSize;
    
    //如果压缩后还是无法达到文件大小，则降低分辨率，继续压缩
    while ([newimageData length]>(FileSize*1024)) {
        
        scalesize = CGSizeMake(scalesize.width*0.8, scalesize.height*0.8);
        
        thumIMG = [self ResizeImageWithImage:outIMG
                                     andSize:scalesize
                                       Scale:NO];
        
        outIMG = [self OnlyCompressToImageWithImage:thumIMG
                                           FileSize:(FileSize*1024)];
        
        newimageData = UIImageJPEGRepresentation(outIMG,1);
        
    }
    NSLog(@"压缩完成");
    return outIMG;
}


#pragma mark --------后台压缩（异步进行，不会卡住前台进程）

// 后台压缩得到 目标大小的 图片Data
+(void)CompressToDataAtBackgroundWithImage:(UIImage *)OldImage
                                  ShowSize:(CGSize)ShowSize
                                  FileSize:(NSInteger)FileSize
                                     block:(DataBlock)DataBlock
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *newIMGData = [YQImageCompressTool CompressToDataWithImage:OldImage
                                                               ShowSize:ShowSize
                                                               FileSize:FileSize];
        DataBlock(newIMGData);
    });
}



//后台压缩得到 目标大小的 UIImage
+(void)CompressToImageAtBackgroundWithImage:(UIImage *)OldImage
                                   ShowSize:(CGSize)ShowSize
                                   FileSize:(NSInteger)FileSize
                                      block:(ImgBlock)ImgBlock
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *newIMG = [YQImageCompressTool CompressToImageWithImage:OldImage
                                                               ShowSize:ShowSize
                                                               FileSize:FileSize];
        ImgBlock(newIMG);
    });
}


#pragma mark --------细化调用方法
//------只压不缩--返回UIImage
//优点：不影响分辨率，不太影响清晰度
//缺点：存在最小限制，可能压不到目标大小
+ (UIImage *)OnlyCompressToImageWithImage:(UIImage *)OldImage
                                 FileSize:(NSInteger)FileSize
{
    
    CGFloat compression    = 0.9f;
    CGFloat minCompression = 0.01f;
    NSData *imageData = UIImageJPEGRepresentation(OldImage,
                                                  compression);
    
    //每次减少的比例
    float scale = 0.1;
    
    //新UIImage的Data
    NSData * newimageData = UIImageJPEGRepresentation(OldImage,1);
    
    //循环条件：没到最小压缩比例，且没压缩到目标大小
    while ((compression > minCompression)&&
           (newimageData.length>FileSize))
    {
        imageData = UIImageJPEGRepresentation(OldImage,
                                              compression);
        UIImage *compressedImage = [UIImage imageWithData:imageData];
        newimageData= UIImageJPEGRepresentation(compressedImage,1);
        
//        NSLog(@"%f,%lu",compression,(unsigned long)newimageData.length);
        
        compression -= scale;
    }
    UIImage *compressedImage = [UIImage imageWithData:newimageData];
    
//    NSLog(@"只压不缩-返回UIImage大小：%lu kb",((NSData *)UIImageJPEGRepresentation(compressedImage,1)).length/1024);
    return compressedImage;
}

//------只压不缩--按NSData大小压缩，返回NSData
+ (NSData *)OnlyCompressToDataWithImage:(UIImage *)OldImage
                               FileSize:(NSInteger)FileSize
{
    CGFloat compression    = 1.0f;
    CGFloat minCompression = 0.001f;
    NSData *imageData = UIImageJPEGRepresentation(OldImage,
                                                  compression);
    //每次减少的比例
    float scale = 0.1;
    
    //循环条件：没到最小压缩比例，且没压缩到目标大小
    while ((compression > minCompression)&&
           (imageData.length>FileSize))
    {
        compression -= scale;
        imageData = UIImageJPEGRepresentation(OldImage,
                                              compression);
        
//        NSLog(@"%f,%lu",compression,(unsigned long)imageData.length);
    }
    //NSLog(@"只压不缩-返回Data大小：%lu kb",imageData.length/1024);
    return imageData;
}



//------只缩不压
//若Scale为YES，则原图会根据Size进行拉伸-会变形
//若Scale为NO，则原图会根据Size进行填充-不会变形
+(UIImage *)ResizeImageWithImage:(UIImage *)OldImage
                         andSize:(CGSize)Size
                           Scale:(BOOL)Scale
{
    UIGraphicsBeginImageContextWithOptions(Size, NO, 0.0);
    
    CGRect rect = CGRectMake(0,
                             0,
                             Size.width,
                             Size.height);
    if (!Scale) {
        
        CGFloat bili_imageWH = OldImage.size.width/
                               OldImage.size.height;
        CGFloat bili_SizeWH  = Size.width/Size.height;
        
        if (bili_imageWH > bili_SizeWH) {
            
            CGFloat bili_SizeH_imageH = Size.height/
                                        OldImage.size.height;
            CGFloat height = OldImage.size.height*
                             bili_SizeH_imageH;
            CGFloat width = height * bili_imageWH;
            CGFloat x = -(width - Size.width)/2;
            CGFloat y = 0;
            rect = CGRectMake(x,y,
                              width,
                              height);
            
        }else{
            
            CGFloat bili_SizeW_imageW = Size.width/
                                        OldImage.size.width;
            CGFloat width = OldImage.size.width *
                            bili_SizeW_imageW;
            CGFloat height = width / bili_imageWH;
            CGFloat x = 0;
            CGFloat y = -(height - Size.height)/2;
            rect = CGRectMake(x,y,
                              width,
                              height);
        }
    }
    
    [[UIColor clearColor] set];
    UIRectFill(rect);
    
    [OldImage drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}




@end

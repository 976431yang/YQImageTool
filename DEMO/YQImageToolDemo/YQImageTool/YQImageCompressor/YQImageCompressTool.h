//
//  YQImageCompressTool.h
//  compressTest
//
//  Created by problemchild on 16/7/7.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQImageCompressTool : NSObject

typedef void(^ImgBlock) (UIImage *resultImage);
typedef void(^DataBlock)(NSData  *resultData);

#pragma mark --------前台压缩（可能比较慢，造成当前进程卡住）
/**
 *  压缩得到 目标大小的 图片Data
 *
 *  @param OldImage 原图
 *  @param ShowSize 将要显示的分辨率
 *  @param FileSize 文件大小限制
 *
 *  @return 压缩得到的图片Data
 */
+(NSData *)CompressToDataWithImage:(UIImage *)OldImage
                          ShowSize:(CGSize)ShowSize
                          FileSize:(NSInteger)FileSize;
/**
 *  压缩得到 目标大小的 UIImage
 *
 *  @param OldImage 原图
 *  @param ShowSize 将要显示的分辨率
 *  @param FileSize 文件大小限制
 *
 *  @return 压缩得到的UIImage
 */
+(UIImage *)CompressToImageWithImage:(UIImage *)OldImage
                            ShowSize:(CGSize)ShowSize
                            FileSize:(NSInteger)FileSize;

#pragma mark --------后台压缩（异步进行，不会卡住前台进程）

/**
 *  后台压缩得到 目标大小的 图片Data
    (使用block的结果，记得按需获取主线程)
 *
 *  @param OldImage  原图
 *  @param ShowSize  将要显示的分辨率
 *  @param FileSize  文件大小限制
 *  @param DataBlock 压缩成功后返回的block
 */
+(void)CompressToDataAtBackgroundWithImage:(UIImage *)OldImage
                                      ShowSize:(CGSize)ShowSize
                                      FileSize:(NSInteger)FileSize
                                         block:(DataBlock)DataBlock;


/**
 *  后台压缩得到 目标大小的 UIImage
    (使用block的结果，记得按需获取主线程)
 *
 *  @param OldImage 原图
 *  @param ShowSize 将要显示的分辨率
 *  @param FileSize 文件大小限制
 *  @param ImgBlock 压缩成功后返回的block
 */
+(void)CompressToImageAtBackgroundWithImage:(UIImage *)OldImage
                                        ShowSize:(CGSize)ShowSize
                                        FileSize:(NSInteger)FileSize
                                           block:(ImgBlock)ImgBlock;

#pragma mark --------细化调用方法
//------只压不缩--按UIImage大小压缩，返回UIImage
//优点：不影响分辨率，不太影响清晰度
//缺点：存在最小限制，可能压不到目标大小
+ (UIImage *)OnlyCompressToImageWithImage:(UIImage *)OldImage
                                 FileSize:(NSInteger)FileSize;

//------只压不缩--按NSData大小压缩，返回NSData
//优点：不影响分辨率，不太影响清晰度
//缺点：存在最小限制，可能压不到目标大小
//默认PNG
+ (NSData *)OnlyCompressToDataWithImage:(UIImage *)OldImage
                               FileSize:(NSInteger)FileSize;


//------只缩不压
//优点：可以大幅降低容量大小
//缺点：影响清晰度
//若Scale为YES，则原图会根据Size进行拉伸-会变形
//若Scale为NO，则原图会根据Size进行填充-不会变形
+(UIImage *)ResizeImageWithImage:(UIImage *)OldImage
                         andSize:(CGSize)Size
                           Scale:(BOOL)Scale;


@end

//
//  YQImageTool.h
//
//  Created by problemchild on 16/3/8.
//  Copyright © 2016年 FreakyBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQImageCompressTool.h"

@interface YQImageTool : NSObject

#pragma mark --------圆角
//--------------------------------------------------圆角

//预先生成圆角图片，直接渲染到UIImageView中去，相比直接在UIImageView.layer中去设置圆角，可以缩短渲染时间。

/**
 *  在原图的四周生成圆角，得到带圆角的图片
 *
 *  @param image           原图
 *  @param width           圆角大小
 *  @param backgroundcolor 背景颜色
 *
 *  @return 新生成的图片
 */
+(UIImage *)getCornerImageAtOriginalImageCornerWithImage:(UIImage *)image
                                           andCornerWith:(CGFloat)width
                                      andBackGroundColor:(UIColor *)backgroundcolor;

/**
 *  根据Size生成圆角图片，图片会拉伸-变形
 *
 *  @param Size            最终想要的图片的尺寸
 *  @param image           原图
 *  @param width           圆角大小
 *  @param backgroundcolor 背景颜色
 *
 *  @return 新生成的图片
 */
+(UIImage *)getCornerImageFitSize:(CGSize)Size
                        WithImage:(UIImage *)image
                    andCornerWith:(CGFloat)width
               andBackGroundColor:(UIColor *)backgroundcolor;

/**
 *  根据Size生成圆角图片，图片会自适应填充，伸展范围以外的部分会被裁剪掉-不会变形
 *
 *  @param Size            最终想要的图片的尺寸
 *  @param image           原图
 *  @param width           圆角大小
 *  @param backgroundcolor 背景颜色
 *
 *  @return 新生成的图片
 */
+(UIImage *)getCornerImageFillSize:(CGSize)Size
                         WithImage:(UIImage *)image
                     andCornerWith:(CGFloat)width
                andBackGroundColor:(UIColor *)backgroundcolor;

#pragma mark --------缩略图
//--------------------------------------------------缩略图
/**
 *  得到图片的缩略图
 *
 *  @param image 原图
 *  @param Size  想得到的缩略图尺寸
 *  @param Scale Scale为YES：原图会根据Size进行拉伸-会变形，Scale为NO：原图会根据Size进行填充-不会变形
 *
 *  @return 新生成的图片
 */
+(UIImage *)getThumbImageWithImage:(UIImage *)image
                           andSize:(CGSize)Size
                             Scale:(BOOL)Scale;

#pragma mark --------水印
//--------------------------------------------------水印
/**
 *  生成带水印的图片
 *
 *  @param backImage  背景图片
 *  @param waterImage 水印图片
 *  @param waterRect  水印位置及大小
 *  @param alpha      水印透明度
 *  @param waterScale 水印是否根据Rect改变长宽比
 *
 *  @return 新生成的图片
 */
+(UIImage *)GetWaterPrintedImageWithBackImage:(UIImage *)backImage
                                andWaterImage:(UIImage *)waterImage
                                       inRect:(CGRect)waterRect
                                        alpha:(CGFloat)alpha
                                   waterScale:(BOOL)waterScale;

#pragma mark --------裁剪
//--------------------------------------------------裁剪
/**
 *  裁剪图片
 注：若裁剪范围超出原图尺寸，则会用背景色填充缺失部位
 *
 *  @param image     原图
 *  @param Point     坐标
 *  @param Size      大小
 *  @param backColor 背景色
 *
 *  @return 新生成的图片
 */
+(UIImage *)cutImageWithImage:(UIImage *)image
                      atPoint:(CGPoint)Point
                     withSize:(CGSize)Size
              backgroundColor:(UIColor *)backColor;

#pragma mark --------根据遮罩图形状裁剪
//--------------------------------------------------根据遮罩图形状裁剪
/**
 *  根据遮罩图片的形状，裁剪原图，并生成新的图片
 原图与遮罩图片宽高最好都是1：1。若比例不同，则会居中。
 若因比例问题达不到效果，可用下面的UIview转UIImage的方法，先制作1：1的UIview，然后转成UIImage使用此功能
 *
 *  @param MaskImage 遮罩图片：遮罩图片最好是要显示的区域为纯黑色，不显示的区域为透明色。
 *  @param Backimage 准备裁剪的图片
 *
 *  @return 新生成的图片
 */
+(UIImage *)creatImageWithMaskImage:(UIImage *)MaskImage
                       andBackimage:(UIImage *)Backimage;

#pragma mark --------生成阴影
//--------------------------------------------------生成阴影
/**
 *  生成带阴影的图片
 *
 *  @param image     原图
 *  @param offset    横纵方向的偏移
 *  @param blurWidth 模糊程度
 *  @param Alpha     阴影透明度
 *  @param Color     阴影颜色
 *
 *  @return 新生成的图片
 */
+(UIImage *)creatShadowImageWithOriginalImage:(UIImage *)image
                              andShadowOffset:(CGSize)offset
                                 andBlurWidth:(CGFloat)blurWidth
                                     andAlpha:(CGFloat)Alpha
                                     andColor:(UIColor *)Color;

#pragma mark --------旋转
//--------------------------------------------------旋转
/**
 *  得到旋转后的图片
 *
 *  @param image 原图
 *  @param Angle 角度（0~360）
 *
 *  @return 新生成的图片
 */
+(UIImage  *)GetRotationImageWithImage:(UIImage *)image
                                 Angle:(CGFloat)Angle;

#pragma mark --------UIView转图片，提前渲染
//--------------------------------------------------UIView转图片，提前渲染
/**
 *  把UIView渲染成图片
 注：由于ios的编程像素和实际显示像素不同，在X2和X3的retina屏幕设备上，使用此方法生成的图片大小将会被还原成1倍像素，
 从而导致再次显示到UIImageView上显示时，清晰度下降。所以使用此方法前，请先将要转换的UIview及它的所有SubView
 的frame里的坐标和大小都根据需要X2或X3。
 *
 *  @param view 想渲染的UIView
 *
 *  @return 渲染出的图片
 */
+(UIImage *)imageWithUIView:(UIView *)view;

@end

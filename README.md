#YQImageTool
[![Build Status](https://travis-ci.org/976431yang/YQImageTool.svg?branch=master)](https://travis-ci.org/976431yang/YQImageTool)
[![Pod Version](https://img.shields.io/badge/pod-1.0.0-blue.svg)](http://cocoadocs.org/docsets/YQImageCompressor/)
[![Pod Platform](https://img.shields.io/badge/platform-ios-lightgray.svg)](http://cocoadocs.org/docsets/YQImageCompressor/)

###微博：畸形滴小男孩
简易图片处理工具：圆角、缩略图、水印、裁剪、根据遮罩图形状裁剪、阴影、旋转、渲染UIView成图片

####2种使用方法：
-下载文件直接拖到工程中使用,然后：
```objective-c
#import "YQImageTool.h"
```
-使用CocoaPods:
```
Podfile: pod 'YQImageTool'
```
```objective-c
#import "YQImageTool.h"
```

#### 目录
- [圆角](#--------------------------------------------------圆角)
- [缩略图](#--------------------------------------------------缩略图)
- [水印](#--------------------------------------------------水印)
- [裁剪](#--------------------------------------------------裁剪)
- [根据遮罩图形状裁剪](#--------------------------------------------------根据遮罩图形状裁剪)
- [生成带阴影的图片](#--------------------------------------------------生成带阴影的图片)
- [旋转](#--------------------------------------------------旋转)
- [UIView转图片，提前渲染](#--------------------------------------------------UIView转图片，提前渲染)
- [图片压缩](#--------------------------------------------------图片压缩)





####--------------------------------------------------圆角
- 预先生成圆角图片，直接渲染到UIImageView中去，相比直接在UIImageView.layer中去设置圆角，可以缩短渲染时间。

######在原图的四周生成圆角，得到带圆角的图片
```Objective-C
+(UIImage *)getCornerImageAtOriginalImageCornerWithImage:(UIImage *)image
                                           andCornerWith:(CGFloat)width
                                      andBackGroundColor:(UIColor *)backgroundcolor;
```

######根据Size生成圆角图片，图片会拉伸-变形
```Objective-C
+(UIImage *)getCornerImageFitSize:(CGSize)Size
                       WithImage:(UIImage *)image
                   andCornerWith:(CGFloat)width
              andBackGroundColor:(UIColor *)backgroundcolor;
```
######根据Size生成圆角图片，图片会自适应填充，伸展范围以外的部分会被裁剪掉-不会变形
```Objective-C
+(UIImage *)getCornerImageFillSize:(CGSize)Size
                        WithImage:(UIImage *)image
                    andCornerWith:(CGFloat)width
               andBackGroundColor:(UIColor *)backgroundcolor;
                       
```
######Example
 ![image](https://github.com/976431yang/YQImageTool/blob/master/DEMO/ScreenShoot/corner.png)

<br/>
####--------------------------------------------------缩略图
```Objective-C
//若Scale为YES，则原图会根据Size进行拉伸-会变形
//若Scale为NO，则原图会根据Size进行填充-不会变形

+(UIImage *)getThumbImageWithImage:(UIImage *)image
                           andSize:(CGSize)Size
                             Scale:(BOOL)Scale;
                                     
```
######Example
 ![image](https://github.com/976431yang/YQImageTool/blob/master/DEMO/ScreenShoot/thum.png)
<br/>
####--------------------------------------------------水印
######生成带水印的图片
```Objective-C
//backImage:背景图片，waterImage：水印图片，
//waterRect：水印位置及大小，alpha：水印透明度，
//waterScale：水印是否根据Rect改变长宽比

+(UIImage *)GetWaterPrintedImageWithBackImage:(UIImage *)backImage
                                andWaterImage:(UIImage *)waterImage
                                       inRect:(CGRect)waterRect
                                        alpha:(CGFloat)alpha
                                   waterScale:(BOOL)waterScale;
        
```
######Example
 ![image](https://github.com/976431yang/YQImageTool/blob/master/DEMO/ScreenShoot/water.png)
<br/>
####--------------------------------------------------裁剪
```Objective-C
//参数：原图、坐标、大小、背景色
//若裁剪范围超出原图尺寸，则会用背景色填充缺失部位

+(UIImage *)cutImageWithImage:(UIImage *)image
                      atPoint:(CGPoint)Point
                     withSize:(CGSize)Size
              backgroundColor:(UIColor *)backColor;
        
```
######Example
 ![image](https://github.com/976431yang/YQImageTool/blob/master/DEMO/ScreenShoot/cut.png)
<br/>
####--------------------------------------------------根据遮罩图形状裁剪
- 根据遮罩图片的形状，裁剪原图，并生成新的图片
- 遮罩图片：遮罩图片最好是要显示的区域为纯黑色，不显示的区域为透明色。
- 原图与遮罩图片宽高最好都是1：1。若比例不同，则会居中。
- 若因比例问题达不到效果，可用下面的UIview转UIImage的方法，先制作1：1的UIview，然后转成UIImage使用此功能

```Objective-C
+(UIImage *)creatImageWithMaskImage:(UIImage *)MaskImage
                       andBackimage:(UIImage *)Backimage;
        
```
######Example
 ![image](https://github.com/976431yang/YQImageTool/blob/master/DEMO/ScreenShoot/mask.png)
<br/>
####--------------------------------------------------生成带阴影的图片
```Objective-C
//ShadowOffset:横纵方向的偏移
//BlurWidth   :边缘模糊宽度
//Alpha       :透明度
//Color       :阴影颜色

+(UIImage *)creatShadowImageWithOriginalImage:(UIImage *)image
                              andShadowOffset:(CGSize)offset
                                 andBlurWidth:(CGFloat)blurWidth
                                     andAlpha:(CGFloat)Alpha
                                     andColor:(UIColor *)Color;

```
######Example
 ![image](https://github.com/976431yang/YQImageTool/blob/master/DEMO/ScreenShoot/shadow.png)
<br/>
####--------------------------------------------------旋转
```Objective-C
//Angle:角度（0~360）

+(UIImage  *)GetRotationImageWithImage:(UIImage *)image
                                 Angle:(CGFloat)Angle;
        
```
######Example
 ![image](https://github.com/976431yang/YQImageTool/blob/master/DEMO/ScreenShoot/rotation.png)
<br/>
####--------------------------------------------------UIView转图片，提前渲染
- 把UIView及它的子类控件 转换为UIImage
- 注：由于ios的编程像素和实际显示像素不同，在X2和X3的retina屏幕设备上，使用此方法生成的图片大小将会被还原成1倍像素，
- 从而导致再次显示到UIImageView上显示时，清晰度下降。
- 所以使用此方法前，请先将要转换的UIview及它的所有SubView的frame里的坐标和大小都根据需要X2或X3。
```Objective-C 
+(UIImage *)imageWithUIView:(UIView *)view;
```
######Example
 ![image](https://github.com/976431yang/YQImageTool/blob/master/DEMO/ScreenShoot/view.png)

####--------------------------------------------------图片压缩
自动引用:[YQImageCompressor](https://github.com/976431yang/YQImageCompressor/)
使用方法: https://github.com/976431yang/YQImageCompressor/






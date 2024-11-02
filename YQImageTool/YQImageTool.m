//
//  YQImageTool.h
//
//  Created by problemchild on 16/3/8.
//  Copyright © 2016年 FreakyBoy. All rights reserved.
//

#import "YQImageTool.h"
#import "math.h"

#define PAI 3.1415926535897932384

@implementation YQImageTool

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
+ (UIImage *)getCornerImageAtOriginalImageCornerWithImage:(UIImage *)image
                                            andCornerWith:(CGFloat)width
                                       andBackGroundColor:(UIColor *)backgroundcolor {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    CGRect rect   = CGRectMake(0, 0, image.size.width, image.size.height);
    
    [backgroundcolor set];
    UIRectFill(bounds);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:width] addClip];
    [image drawInRect:bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  根据Size生成圆角图片，图片会拉伸-变形
 *
 *  @param size            最终想要的图片的尺寸
 *  @param image           原图
 *  @param width           圆角大小
 *  @param backgroundcolor 背景颜色
 *
 *  @return 新生成的图片
 */
+ (UIImage *)getCornerImageFitSize:(CGSize)size
                        WithImage:(UIImage *)image
                    andCornerWith:(CGFloat)width
               andBackGroundColor:(UIColor *)backgroundcolor {
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    CGRect rect   = CGRectMake(0, 0, size.width, size.height);
    
    [backgroundcolor set];
    UIRectFill(bounds);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:width] addClip];
    [image drawInRect:bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  根据Size生成圆角图片，图片会自适应填充，伸展范围以外的部分会被裁剪掉-不会变形
 *
 *  @param size            最终想要的图片的尺寸
 *  @param image           原图
 *  @param width           圆角大小
 *  @param backgroundcolor 背景颜色
 *
 *  @return 新生成的图片
 */
+ (UIImage *)getCornerImageFillSize:(CGSize)size
                          WithImage:(UIImage *)image
                      andCornerWith:(CGFloat)width
                 andBackGroundColor:(UIColor *)backgroundcolor {
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    
    CGFloat bili_imageWH = image.size.width/image.size.height;
    CGFloat bili_SizeWH  = size.width/size.height;
    
    CGRect bounds;
    
    if (bili_imageWH > bili_SizeWH) {
        CGFloat bili_SizeH_imageH = size.height/image.size.height;
        CGFloat height = image.size.height*bili_SizeH_imageH;
        CGFloat width = height * bili_imageWH;
        CGFloat x = - (width - size.width)/2;
        CGFloat y = 0;
        bounds = CGRectMake(x, y, width, height);
    }else{
        CGFloat bili_SizeW_imageW = size.width/image.size.width;
        CGFloat width = image.size.width * bili_SizeW_imageW;
        CGFloat height = width / bili_imageWH;
        CGFloat x = 0;
        CGFloat y = - (height - size.height)/2;
        bounds = CGRectMake(x, y, width, height);
    }
    CGRect rect   = CGRectMake(0, 0, size.width, size.height);
    
    [backgroundcolor set];
    UIRectFill(bounds);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:width] addClip];
    [image drawInRect:bounds];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

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
+ (UIImage *)getWaterPrintedImageWithBackImage:(UIImage *)backImage
                                andWaterImage:(UIImage *)waterImage
                                       inRect:(CGRect)waterRect
                                        alpha:(CGFloat)alpha
                                   waterScale:(BOOL)waterScale {
    UIImageView *backIMGV = [[UIImageView alloc]init];
    backIMGV.backgroundColor = [UIColor clearColor];
    backIMGV.frame = CGRectMake(0, 0,
                                backImage.size.width,
                                backImage.size.height);
    backIMGV.contentMode = UIViewContentModeScaleAspectFill;
    backIMGV.image = backImage;
    
    UIImageView *waterIMGV = [[UIImageView alloc]init];
    waterIMGV.backgroundColor = [UIColor clearColor];
    waterIMGV.frame = CGRectMake(waterRect.origin.x,
                                 waterRect.origin.y,
                                 waterRect.size.width,
                                 waterRect.size.height);
    if (waterScale) {
        waterIMGV.contentMode = UIViewContentModeScaleToFill;
    } else {
        waterIMGV.contentMode = UIViewContentModeScaleAspectFill;
    }
    waterIMGV.alpha = alpha;
    waterIMGV.image = waterImage;
    
    [backIMGV addSubview:waterIMGV];
    
    UIImage *outImage = [self imageWithUIView:backIMGV];
    
    return outImage;
}

#pragma mark --------根据遮罩图形状裁剪
//--------------------------------------------------根据遮罩图形状裁剪
/**
 *  根据遮罩图片的形状，裁剪原图，并生成新的图片
 原图与遮罩图片宽高最好都是1：1。若比例不同，则会居中。
 若因比例问题达不到效果，可用下面的UIview转UIImage的方法，先制作1：1的UIview，然后转成UIImage使用此功能
 *
 *  @param maskImage 遮罩图片：遮罩图片最好是要显示的区域为纯黑色，不显示的区域为透明色。
 *  @param backimage 准备裁剪的图片
 *
 *  @return 新生成的图片
 */
+ (UIImage *)creatImageWithMaskImage:(UIImage *)maskImage
                        andBackimage:(UIImage *)backimage {
    
    CGRect rect;
    
    if (backimage.size.height>backimage.size.width) {
        rect = CGRectMake(0,
                          (backimage.size.height - backimage.size.width),
                          backimage.size.width * 2,
                          backimage.size.width * 2);
    } else {
        rect = CGRectMake((backimage.size.width - backimage.size.height),
                          0,
                          backimage.size.height * 2,
                          backimage.size.height * 2);
    }
    
    UIImage *cutIMG = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([backimage CGImage], rect)];
    
    //遮罩图
    CGImageRef maskCGImage = maskImage.CGImage;
    //原图
    CGImageRef originImage = cutIMG.CGImage;
    
    CGContextRef mainViewContentContext;
    CGColorSpaceRef colorSpace;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    mainViewContentContext = CGBitmapContextCreate(NULL,
                                                   rect.size.width,
                                                   rect.size.height,
                                                   8,
                                                   0,
                                                   colorSpace,
                                                   kCGImageAlphaPremultipliedLast);
    
    CGColorSpaceRelease(colorSpace);
    if (mainViewContentContext == NULL) {
        NSLog(@"error");
    }
    
    CGContextClipToMask(mainViewContentContext,
                        CGRectMake(0, 0, rect.size.width, rect.size.height),
                        maskCGImage);
    
    CGContextDrawImage(mainViewContentContext,
                       CGRectMake(0, 0, rect.size.width, rect.size.height),
                       originImage);
    
    CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    UIImage *theImage = [UIImage imageWithCGImage:mainViewContentBitmapContext];
    CGImageRelease(mainViewContentBitmapContext);
    
    return theImage;
    
}

#pragma mark --------缩略图
//--------------------------------------------------缩略图
/**
 *  得到图片的缩略图
 *
 *  @param image 原图
 *  @param size  想得到的缩略图尺寸
 *  @param scale scale为YES：原图会根据Size进行拉伸-会变形，scale为NO：原图会根据size进行填充-不会变形
 *
 *  @return 新生成的图片
 */
+ (UIImage *)getThumbImageWithImage:(UIImage *)image andSize:(CGSize)size scale:(BOOL)scale {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    if (!scale) {
        CGFloat bili_imageWH = image.size.width / image.size.height;
        CGFloat bili_SizeWH  = size.width / size.height;
        
        if (bili_imageWH > bili_SizeWH) {
            CGFloat bili_SizeH_imageH = size.height / image.size.height;
            CGFloat height = image.size.height * bili_SizeH_imageH;
            CGFloat width = height * bili_imageWH;
            CGFloat x = - (width - size.width)/2;
            CGFloat y = 0;
            rect = CGRectMake(x, y, width, height);
        } else {
            CGFloat bili_SizeW_imageW = size.width / image.size.width;
            CGFloat width = image.size.width * bili_SizeW_imageW;
            CGFloat height = width / bili_imageWH;
            CGFloat x = 0;
            CGFloat y = - (height - size.height) / 2;
            rect = CGRectMake(x, y, width, height);
        }
    }
    
    [[UIColor clearColor] set];
    UIRectFill(rect);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark --------生成阴影
//--------------------------------------------------生成阴影
/**
 *  生成带阴影的图片
 *
 *  @param image     原图
 *  @param offset    横纵方向的偏移
 *  @param blurWidth 模糊程度
 *  @param alpha     阴影透明度
 *  @param color     阴影颜色
 *
 *  @return 新生成的图片
 */
+ (UIImage *)creatShadowImageWithOriginalImage:(UIImage *)image
                               andShadowOffset:(CGSize)offset
                                  andBlurWidth:(CGFloat)blurWidth
                                      andAlpha:(CGFloat)alpha
                                      andColor:(UIColor *)color {
    CGFloat width  = (image.size.width + offset.width + blurWidth * 4);
    CGFloat height = (image.size.height + offset.height + blurWidth * 4);
    if (offset.width < 0) {
        width  = (image.size.width - offset.width + blurWidth * 4);
    }
    if (offset.height < 0) {
        height = (image.size.height - offset.height + blurWidth * 4);
    }
    
    UIView *rootBackView = [[UIView alloc]initWithFrame:CGRectMake(0,0,
                                                                   width,
                                                                   height)];
    rootBackView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(blurWidth * 2,
                                                                          blurWidth * 2,
                                                                          image.size.width,
                                                                          image.size.height)];
    if (offset.width<0) {
        imageView.frame = CGRectMake(blurWidth * 2 - offset.width,
                                     imageView.frame.origin.y,
                                     imageView.frame.size.width,
                                     imageView.frame.size.height);
    }
    if (offset.height < 0) {
        imageView.frame = CGRectMake(imageView.frame.origin.x,
                                     blurWidth * 2 - offset.height,
                                     imageView.frame.size.width,
                                     imageView.frame.size.height);
    }
    imageView.backgroundColor = [UIColor clearColor];
    imageView.layer.shadowOffset = CGSizeMake(offset.width, offset.height);
    imageView.layer.shadowRadius = blurWidth;
    imageView.layer.shadowOpacity = alpha;
    imageView.layer.shadowColor  = color.CGColor;
    imageView.image = image;
    
    [rootBackView addSubview:imageView];
    
    UIImage *newImage = [self imageWithUIView:rootBackView];
    return newImage;
}

#pragma mark --------旋转
//--------------------------------------------------旋转
/**
 *  得到旋转后的图片
 *
 *  @param image 原图
 *  @param angle 角度（0~360）
 *
 *  @return 新生成的图片
 */
+ (UIImage *)getRotationImageWithImage:(UIImage *)image
                                 angle:(CGFloat)angle {
    
    UIView *RootBackView = [[UIView alloc] initWithFrame:CGRectMake(0,0,
                                                                    image.size.width,
                                                                    image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(angle* M_PI / 180);
    RootBackView.transform = t;
    CGSize rotatedSize = RootBackView.frame.size;
    
    UIGraphicsBeginImageContextWithOptions(rotatedSize, NO, image.scale);
    
    CGContextRef theContext = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(theContext, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(theContext, angle * M_PI / 180);
    CGContextScaleCTM(theContext, 1.0, -1.0);
    
    CGContextDrawImage(theContext,
                       CGRectMake(-image.size.width / 2,
                                  -image.size.height / 2,
                                  image.size.width,
                                  image.size.height),
                       [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


#pragma mark --------裁剪
//--------------------------------------------------裁剪
/**
 *  裁剪图片
 注：若裁剪范围超出原图尺寸，则会用背景色填充缺失部位
 *
 *  @param image     原图
 *  @param point     坐标
 *  @param size      大小
 *  @param backColor 背景色
 *
 *  @return 新生成的图片
 */
+ (UIImage *)cutImageWithImage:(UIImage *)image
                      atPoint:(CGPoint)point
                     withSize:(CGSize)size
              backgroundColor:(UIColor *)backColor {
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    CGRect rect   = CGRectMake(-point.x, -point.y,
                               image.size.width,
                               image.size.height);
    
    [backColor set];
    UIRectFill(bounds);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark --------UIView转图片，提前渲染
//--------------------------------------------------UIView转图片，提前渲染
/**
 *  把UIView渲染成图片
 *
 *  @param view 想渲染的UIView
 *
 *  @return 渲染出的图片
 */
+ (UIImage *)imageWithUIView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tImage;
}

@end

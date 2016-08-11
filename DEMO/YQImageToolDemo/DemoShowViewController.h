//
//  DemoShowViewController.h
//  YQImageCompressorDemo
//
//  Created by problemchild on 16/8/9.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQImageCompressTool.h"

@interface DemoShowViewController : UIViewController

/**
 *  展示原图的IMGV
 */
@property(nonatomic,strong)UIImageView *OldIMGV;

/**
 *  展示新图的IMGV
 */
@property(nonatomic,strong)UIImageView *NewIMGV;

/**
 *  新图片的尺寸，为了Demo效果更明显，将目标分辨率设大一些
 */
@property(nonatomic)CGSize NewIMGSize;

/**
 *  原图，此原图挺大的
 */
@property(nonatomic,strong)UIImage *oldIMG;


/**
 *  title的备份
 */
@property(nonatomic,strong)NSString *titleStr;


//弹窗提示结果
-(void)alertResult:(NSString *)string;

@end

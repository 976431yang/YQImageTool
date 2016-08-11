//
//  IMageToolDemoShowViewController.h
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageToolDemoItem.h"

#import "YQImageTool.h"

@interface IMageToolDemoShowViewController : UIViewController

@property(nonatomic,strong)ImageToolDemoItem *item1;

@property(nonatomic,strong)ImageToolDemoItem *item2;

@property(nonatomic,strong)ImageToolDemoItem *item3;

@property(nonatomic,strong)ImageToolDemoItem *item4;

@property(nonatomic,strong)UIImage *bigIMG;

@property(nonatomic,strong)UIImage *normalIMG;

@property(nonatomic,strong)UIImage *maskIMG;

@end

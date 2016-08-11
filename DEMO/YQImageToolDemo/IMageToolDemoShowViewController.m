//
//  IMageToolDemoShowViewController.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "IMageToolDemoShowViewController.h"


@interface IMageToolDemoShowViewController ()

@end

@implementation IMageToolDemoShowViewController

#pragma mark --------LazyLoad
-(UIImage *)bigIMG{
    _bigIMG = (_bigIMG)?_bigIMG:[UIImage imageNamed:@"test.png"];
    return _bigIMG;
}

-(UIImage *)normalIMG{
    _normalIMG = (_normalIMG)?_normalIMG:[UIImage imageNamed:@"test1.jpg"];
    return _normalIMG;
}

-(UIImage *)maskIMG{
    _maskIMG = (_maskIMG)?_maskIMG:[UIImage imageNamed:@"mask.png"];
    return _maskIMG;
}

#pragma mark --------System

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setup];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //--------------------------------------------------判断是pop还是push
    //    NSArray *viewControllers = self.navigationController.viewControllers;
    //    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self)
    //    {
    //        self.removeFlag = NO;
    //    }
    //    else if ([viewControllers indexOfObject:self] == NSNotFound)
    //    {
    //        self.removeFlag = YES;
    //    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //    if (self.removeFlag == YES)
    //    {
    //        //清除各种代理，通知
    //        //        self.pickerBrowser.delegate = nil;
    //        //        self.pickerBrowser.dataSource = nil;
    //
    //        //remove所有view
    //        NSArray *subviews = [[NSArray alloc] initWithArray:self.view.subviews];
    //        for (UIView *subview in subviews)
    //        {
    //            [subview removeFromSuperview];
    //        }
    //
    //    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark --------Functions
/**
 *  初始化
 */
-(void)setup{
    
    
    
    self.item1 = [[ImageToolDemoItem alloc]initWithFrame:CGRectMake(0,
                                                                    64,
                                                                    kScreenWidth/2-5,
                                                                    (kScreenHeight-64-10)/2)];
    [self.view addSubview:self.item1];
    
    self.item2 = [[ImageToolDemoItem alloc]initWithFrame:CGRectMake(kScreenWidth/2+5,
                                                                    64,
                                                                    kScreenWidth/2-5,
                                                                    (kScreenHeight-64-10)/2)];
    [self.view addSubview:self.item2];
    
    self.item3 = [[ImageToolDemoItem alloc]initWithFrame:CGRectMake(0,
                                                                    64+(kScreenHeight-64-10)/2,
                                                                    kScreenWidth/2-5,
                                                                    (kScreenHeight-64-10)/2)];
    [self.view addSubview:self.item3];
    
    self.item4 = [[ImageToolDemoItem alloc]initWithFrame:CGRectMake(kScreenWidth/2+5,
                                                                    64+(kScreenHeight-64-10)/2,
                                                                    kScreenWidth/2-5,
                                                                    (kScreenHeight-64-10)/2)];
    [self.view addSubview:self.item4];
}

@end

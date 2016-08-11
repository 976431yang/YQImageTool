//
//  ViewController.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"

#import "YQImageTool.h"

#import "CompressorViewController.h"


#import "CornerIMGVC1.h"
#import "ThumVC.h"
#import "WaterVC.h"
#import "CutVC.h"
#import "MaskVC.h"
#import "ShadowVC.h"
#import "RotationVC.h"
#import "ViewVC.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tabV;
@end

@implementation ViewController

#pragma mark --------LazyLoad



#pragma mark --------System

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark --------Functions
//初始化
-(void)setup{
    
    self.title = @"YQImageTool";
    
    
    self.tabV = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tabV.delegate = self;
    self.tabV.dataSource = self;
    self.tabV.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    [self.view addSubview:self.tabV];
    
    //注册重用单元格
    [self.tabV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyCell"];
}


#pragma mark --------UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 9;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
            
        default:
            return 1;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *TitleLab = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 kScreenWidth,
                                                                 20)];
    TitleLab.font = [UIFont systemFontOfSize:15];
    TitleLab.textAlignment = NSTextAlignmentCenter;
    TitleLab.numberOfLines = 0;
    
    switch (section) {
        case 0:
        {
            TitleLab.text = @"圆角";
        }
            break;
        case 1:
        {
            TitleLab.text = @"缩略图";
        }
            break;
        case 2:
        {
            TitleLab.text = @"水印";
        }
            break;
        case 3:
        {
            TitleLab.text = @"裁剪";
        }
            break;
        case 4:
        {
            TitleLab.text = @"根据遮罩图形状裁剪";
        }
            break;
        case 5:
        {
            TitleLab.text = @"生成带阴影的图片";
        }
            break;
        case 6:
        {
            TitleLab.text = @"旋转";
        }
            break;
        case 7:
        {
            TitleLab.text = @"UIView转图片，提前渲染";
        }
            break;
        case 8:
        {
            TitleLab.text = @"图片压缩";
        }
            break;
            
        default:
            break;
    }
    
    return TitleLab;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //自动从重用队列中取得名称是MyCell的注册对象,如果没有，就会生成一个
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    cell.textLabel.numberOfLines = 0;
    
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = @"得到带圆角的图片";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"获取缩略图";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"生成带水印的图片";
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"裁剪图片";
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"根据遮罩图形状裁剪";
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"生成带阴影的图片";
        }
            break;
        case 6:
        {
            cell.textLabel.text = @"生成旋转的图片";
        }
            break;
        case 7:
        {
            cell.textLabel.text = @"UIView转图片";
        }
            break;
        case 8:
        {
            cell.textLabel.text = @"图片压缩";
        }
            break;
            
        default:
            cell.textLabel.text = @"Hello World";
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tabV deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.section) {
        case 0:
        {
            [self.navigationController pushViewController:[CornerIMGVC1 new] animated:YES];
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:[ThumVC new] animated:YES];
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[WaterVC new] animated:YES];
        }
            break;
        case 3:
        {
            [self.navigationController pushViewController:[CutVC new] animated:YES];
        }
            break;
        case 4:
        {
            [self.navigationController pushViewController:[MaskVC new] animated:YES];
        }
            break;
        case 5:
        {
            [self.navigationController pushViewController:[ShadowVC new] animated:YES];
        }
            break;
        case 6:
        {
            [self.navigationController pushViewController:[RotationVC new] animated:YES];
        }
            break;
        case 7:
        {
            [self.navigationController pushViewController:[ViewVC new] animated:YES];
        }
            break;
        case 8:
        {
            [self.navigationController pushViewController:[CompressorViewController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end

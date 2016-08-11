//
//  CompressorViewController.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "CompressorViewController.h"

#import "YQImageTool.h"

#import "BackDataDemo.h"
#import "BackImageDemo.h"
#import "FrontDataDemo.h"
#import "FrontImageDemo.h"
#import "OnlyCompressImageDemo.h"
#import "OnlyCompressDataDemo.h"
#import "OnlyResizeDemo.h"

@interface CompressorViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tabV;

@end

@implementation CompressorViewController

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
    
    self.title = @"压缩到200KB以下";
    
    self.navigationItem.rightBarButtonItem =({
        UIBarButtonItem *BTN = [[UIBarButtonItem alloc]initWithTitle:@"说明"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(ShowInfo)];
        BTN;
    });
    
    self.tabV = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tabV.delegate = self;
    self.tabV.dataSource = self;
    self.tabV.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    [self.view addSubview:self.tabV];
    
    //注册重用单元格
    [self.tabV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyCell"];
}

-(void)ShowInfo{
    UIAlertView *alertDialog;
    alertDialog = [[UIAlertView alloc]
                   initWithTitle:@"说明"
                   message:@"为了更明显地表现各种方法的差别，原图提交比较大(源文件22M)，压缩目标的分辨率尺寸也设置得偏大一些(详情页下方IMGV的尺寸的2倍)"
                   delegate:nil
                   cancelButtonTitle:@"OK"
                   otherButtonTitles: nil];
    [alertDialog show];
}

#pragma mark --------UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 2:
            return 3;
            break;
            
        default:
            return 2;
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
            TitleLab.text = @"后台压缩（异步进行，不会卡住前台进程）";
        }
            break;
        case 1:
        {
            TitleLab.text = @"前台压缩（可能比较慢，造成当前进程卡住）";
        }
            break;
        case 2:
        {
            TitleLab.text = @"细化调用方法";
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
    
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"后台压缩得到 目标大小的 图片Data";
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"后台压缩得到 目标大小的 UIImage";
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"压缩得到 目标大小的 图片Data";
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"压缩得到 目标大小的 UIImage";
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"只压不缩--按NSData大小压缩，返回NSData";
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"只压不缩--按UIImage大小压缩，返回UIImage";
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"只缩不压";
                }
                    break;
                default:
                    break;
            }
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
    
    UITableViewCell *cell = [self.tabV cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    BackDataDemo *vc = [BackDataDemo new];
                    vc.titleStr = cell.textLabel.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    BackImageDemo *vc = [BackImageDemo new];
                    vc.titleStr = cell.textLabel.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    FrontDataDemo *vc = [FrontDataDemo new];
                    vc.titleStr = cell.textLabel.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    FrontImageDemo *vc = [FrontImageDemo new];
                    vc.titleStr = cell.textLabel.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    OnlyCompressDataDemo *vc = [OnlyCompressDataDemo new];
                    vc.titleStr = cell.textLabel.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    OnlyCompressImageDemo *vc = [OnlyCompressImageDemo new];
                    vc.titleStr = cell.textLabel.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:
                {
                    OnlyResizeDemo *vc = [OnlyResizeDemo new];
                    vc.titleStr = cell.textLabel.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}


@end

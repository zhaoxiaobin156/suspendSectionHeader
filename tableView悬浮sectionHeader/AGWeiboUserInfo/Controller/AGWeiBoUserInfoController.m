//
//  AGWeiBoUserInfoController.m
//  AGWeiboUserInfo
//
//  Created by Agenric on 15/10/8.
//  Copyright (c) 2015年 Agenric. All rights reserved.
//


#define kTableViewHeaderDefH    200
#define kTableViewHeaderMinH    64
#define kTableViewTabH          44

#import "AGWeiBoUserInfoController.h"
#import "UIImage+Color.h"
#import "AGTestViewController.h"

#import "ScollowIndicatorView.h"

@interface AGWeiBoUserInfoController ()<UITableViewDataSource, UITableViewDelegate>
{
    CGFloat _defaultOffsetY;
}
@property (nonatomic, strong) UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *singVC;

@property (weak, nonatomic) IBOutlet UIButton *videoBtn;

@property (weak, nonatomic) IBOutlet UIButton *jianjieBtn;


#pragma mark ---MB
@property(nonatomic,strong)ScollowIndicatorView *indicaor;



@end

@implementation AGWeiBoUserInfoController

-(ScollowIndicatorView *)indicaor{
    if (!_indicaor) {
        _indicaor  = [[ScollowIndicatorView alloc]init];
        _indicaor.backgroundColor = [UIColor whiteColor];
        
        CGFloat height = self.tableViewTab.bounds.size.height;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _indicaor.frame = CGRectMake(0,0 , width, height);
        
    
        
        _indicaor.mut = @[@"全部",@"视频"];
        
    }
    return  _indicaor;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableViewTab addSubview:self.indicaor];
    self.tableViewTab.backgroundColor = [UIColor greenColor];
    
    
    [self setupUI];
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 255;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"选中第%ld个",indexPath.row);
    
    AGTestViewController *testVC = [[AGTestViewController alloc] init];
    
    [self.navigationController pushViewController:testVC animated:YES];
    
}

#pragma mark - UITableView Datasources
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"myIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor redColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}




#pragma mark - setupUI
- (void)setupUI {
    // tableView
    _headImage.layer.cornerRadius = self.headImage.bounds.size.height *0.5;
    
    _headImage.clipsToBounds = YES;
    
    _defaultOffsetY = -(kTableViewHeaderDefH + kTableViewTabH);
    [self.mainTableView setContentInset:UIEdgeInsetsMake(-_defaultOffsetY, 0, 0, 0)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.mainTableView setTableFooterView:[[UIView alloc] init]];
    
    // navigationBar
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self setleftBtn];
    [self setRightBtn];

    // title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Agenric";
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    _titleLabel = titleLabel;
    _titleLabel.alpha = 0;
    _titleLabel.hidden = YES;
}

-(void)setleftBtn
{
    
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //修改按钮向右偏移10 point
    [settingButton setFrame:CGRectMake(-15.0, 0.0, 44.0, 44.0)];
    [settingButton addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [settingButton setTitle:@"返回" forState:UIControlStateNormal];
    
    //修改方法
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
    [view addSubview:settingButton];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
}

-(void)goback
{

    [self.navigationController popViewControllerAnimated:YES];
    
}


/**设置导航栏右边按钮*/

-(void)setRightBtn
{
    
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //修改按钮向右偏移10 point
    [settingButton setFrame:CGRectMake(10.0, 0.0, 44.0, 44.0)];
    [settingButton addTarget:self action:@selector(ToreportBtn) forControlEvents:UIControlEventTouchUpInside];
    [settingButton setTitle:@"举报" forState:UIControlStateNormal];
    
    //修改方法
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
    [view addSubview:settingButton];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

-(void)ToreportBtn
{
    NSLog(@"点击导航栏右边按钮");
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f",offsetY);
    NSLog(@"%f",_defaultOffsetY);
    CGFloat delta = offsetY - _defaultOffsetY;
    
    CGFloat height = kTableViewHeaderDefH - delta;
    
//    NSLog(@"offsetY----%f",offsetY);
//    NSLog(@"delta------%f",delta);
//    NSLog(@"height-----%f",height);
    if (height < kTableViewHeaderMinH) {
        height = kTableViewHeaderMinH;
    }
    _tableViewHeaderH.constant = height;
    
    CGFloat alpha = delta / (kTableViewHeaderDefH - kTableViewHeaderMinH);
    if (alpha > 0) {
        _titleLabel.hidden = NO;
        if (alpha >= 1) {
            alpha = 0.99;
        }
    } else {
        _titleLabel.hidden = YES;
    }
    
    _titleLabel.alpha = alpha;
    
    // 设置导航条的背景图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}


- (IBAction)guanzuBtn:(id)sender {
    
    NSLog(@"点击了关注按钮");

}

- (IBAction)fensiBtn:(id)sender {
    
    NSLog(@"点击了导粉丝按钮");

}

- (IBAction)dianzanBtn:(id)sender {
    
    NSLog(@"点击了点赞按钮");

}
//  视频

//  简介


@end

//
//  FirstViewController.m
//  吃货GOGOGO
//
//  Created by qingyun on 16/1/7.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "FirstViewController.h"
#import "SDCycleScrollView.h"
#import "AFNetworking.h"
#import "FirstTopData.h"
#import "NSString+GetUrl.h"
#import "FirstTableViewCell.h"
#import "FirstCelldate.h"
#import "MJRefresh.h"

#import "TZThirdViewController.h"

#import "UIImageView+WebCache.h"






#define BASE_URL @"http://www.ecook.cn/public/getHomeData.shtml"

#define CELL_URL @"http://www.ecook.cn/public/getHomeWeiboList.shtml"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) SDCycleScrollView *cycleview;

@property (nonatomic,strong) NSMutableArray *imageUrlArr;

@property (nonatomic,strong)NSMutableArray *TopDateArr;

@property (nonatomic,strong) NSMutableArray *cellArr;







@end

@implementation FirstViewController


//初始化

-(NSMutableArray *)imageUrlArr{
    if (_imageUrlArr == nil) {
        _imageUrlArr = [NSMutableArray array];
    }
    return _imageUrlArr;
}


- (NSMutableArray *)TopDateArr{
    if (_TopDateArr == nil) {
        _TopDateArr = [NSMutableArray array];
    }
    return _TopDateArr;
}

- (NSMutableArray *)cellArr
{
    if (_cellArr == nil) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title =@"首页";
    [self addsubView];
    
    [self initCycleview];
    
    [self loadDateFromNet];
    
    [self loadforcell];
    [self addBackgroundView];
   
    
    self.tableview.tableHeaderView = _cycleview;
    
    //上拉加载
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    }

- (void)addBackgroundView{
    
    UIView *viewnew = [[UIView alloc] init];
    UIImageView *imag = [[UIImageView alloc] init];
    imag.frame = CGRectMake(0, 200, self.view.frame.size.width, (self.view.frame.size.height-250));
    imag.image = [UIImage imageNamed:@"new2"];
    [viewnew addSubview:imag];
    self.tableview.backgroundView = viewnew;
    
}


- (void)initCycleview{
    _cycleview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) imageURLStringsGroup:self.imageUrlArr];
    //没有出来的背景
    _cycleview.placeholderImage = [UIImage imageNamed:@"new3"];
    _cycleview.delegate = self;
    //类型
    _cycleview.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    
    _cycleview.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
}
- (void)addsubView {
    _tableview = [[UITableView alloc] initWithFrame:self.view.frame style:  UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    
    _tableview.estimatedRowHeight = 44.0;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_tableview];
    
    
}


//网上请求数据
- (void)loadDateFromNet{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    //响应序列化
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage GET:BASE_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
  
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",dic1);
        NSArray *temp = dic1[@"bannerList"]; 
        for (NSDictionary *dict in temp) {
            FirstTopData *Topdate = [FirstTopData dataWithDictionary:dict];
            [self.TopDateArr addObject:Topdate];
            [self.imageUrlArr addObject:[NSString getImageUrlStr:Topdate.imageid]];
            
        }
        _cycleview.imageURLStringsGroup = self.imageUrlArr ;
    } failure:nil];
    

    
}

/**上拉加载*/

- (void)loadMoreData{
    /**取到模型中最后一个id当参数传进刷新的网路请求中*/
    FirstCelldate *model = [self.cellArr lastObject];
    NSString *lastId = model.firstID;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = lastId;
    [self loadDatefromNet:param];
}


/**
 网络请求
 */
-(void)loadforcell{
    
    [self loadDatefromNet:nil];
    
}

- (void)loadDatefromNet:(NSMutableDictionary *)dict{
    
    AFHTTPSessionManager *manage1 = [AFHTTPSessionManager manager];
    /**响应序列化*/
    manage1.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage1 GET:CELL_URL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /**jeson解析*/
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        /**数组中装要用的数据字典*/
        NSArray *tempcell = dic[@"list"];
        /**便利数组*/
        for (NSDictionary *dict in tempcell) {
            /**字典转模型*/
            FirstCelldate *celldata = [FirstCelldate dataWithDictionary:dict];
            /**全局的数组装模型*/
            [self.cellArr addObject:celldata];
        }
        /**刷新的条件*/
        if (self.cellArr.count > 10) {
            [ self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
           /**更新视图*/
           [self.tableview reloadData];
        
        
    } failure:nil];
    

    
}



/**
 代理方法
 cell的数量
 
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.cellArr.count;
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
     FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"FirstTableViewCell" owner:self options:nil][0];
     
}
    /**取到模型*/
    FirstCelldate *celldata = self.cellArr[indexPath.row];
    /**赋值*/
    cell.celldata = celldata;
    cell.lowView .hidden = YES;
    return cell;
}


/**
 头视图的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

/**
 头视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 10)];
    lab.text = @"今天精选";
    return lab;
}

/**
 跳转页面
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TZThirdViewController *TzVC = [[TZThirdViewController alloc]init];
    
    FirstCelldate  *celldata = self.cellArr[indexPath.row];
    [TzVC setValue:celldata forKey:@"firstCellData"];
    [TzVC setValue:celldata.firstID forKey:@"firstID"];
    [self.navigationController pushViewController:TzVC animated:YES];
    
}


@end

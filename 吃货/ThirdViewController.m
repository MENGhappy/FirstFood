//
//  ThirdViewController.m
//  吃货
//
//  Created by qingyun on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "ThirdViewController.h"
#import "AFNetworking.h"
#import "FirstCelldate.h"
#import "FirstTableViewCell.h"
#import "MJRefresh.h"

#import "TZCelldata.h"

#import "TZThirdViewController.h"


#define CELL_URL @"http://www.ecook.cn/public/getWeiboList.shtml"

@interface ThirdViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) NSString *ID;

@end


@implementation ThirdViewController

- (NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self addsubview];
    [self loadforcell];
    [self addBackgroundView];
    self.navigationItem.title = @"精选";
    //上拉加载
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)addsubview{
    _tableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate =self;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    _tableview.estimatedRowHeight = 44.0;
    [self.view addSubview:_tableview];
}

- (void)addBackgroundView{
    
    UIView *viewnew = [[UIView alloc] init];
    UIImageView *imag = [[UIImageView alloc] init];
    imag.frame = CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height-100));
    imag.image = [UIImage imageNamed:@"new2"];
    [viewnew addSubview:imag];
    self.tableview.backgroundView = viewnew;
    
}
//下拉刷新加载数据
- (void)loadMoreData{
    
    FirstCelldate *model = [self.arr lastObject];
    NSString *lastId = model.firstID;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = lastId;
    [self loaddata:param];
    

}

//第一次请求数据
-(void)loadforcell{
   
    [self loaddata:nil];
   
}
//网络请求
-(void)loaddata:(NSMutableDictionary *)dict{
    
    AFHTTPSessionManager *manage1 = [AFHTTPSessionManager manager];
    //响应序列化
    manage1.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage1 GET:CELL_URL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       // NSLog(@"%@",dic);
        NSArray *tempcell = dic[@"list"];
       // NSLog(@"tempcell%@",tempcell);
        for (NSDictionary *dict in tempcell) {
            FirstCelldate *celldata = [FirstCelldate dataWithDictionary:dict];
            
            [self.arr addObject:celldata];
            
        }
        if (self.arr.count > 10) {
         [ self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableview reloadData];
        
    } failure:nil];
    

    
}

#pragma mark tableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
    return self.arr.count;
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
    static NSString *identify =@"cell";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"FirstTableViewCell" owner:self options:nil][0];
    
 }
    FirstCelldate *celldata = self.arr[indexPath.row];
    cell.celldata = celldata;
    cell.lowView.hidden = YES;
    return cell;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
    TZThirdViewController *TzVC = [[TZThirdViewController alloc]init];
    FirstCelldate  *celldata = self.arr[indexPath.row];
    [TzVC setValue:celldata forKey:@"firstCellData"];
    [TzVC setValue:celldata.firstID forKey:@"firstID"];
    [self.navigationController pushViewController:TzVC animated:YES];
 }


@end

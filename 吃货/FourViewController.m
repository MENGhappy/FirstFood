//
//  FourViewController.m
//  吃货
//
//  Created by qingyun on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "FourViewController.h"
#import "AFNetworking.h"
#import "Fourcell.h"
#import "FourviewCell.h"

#import "TZFourViewController.h"


/**
 全部请求下来的id
 */
#define ID_URL @"http://www.ecook.cn/public/selectRecommendIdsByType.shtml"
//点进去的url
#define CELL_URL @"http://www.ecook.cn/public/selectRecommendsByIds.shtml"



@interface FourViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *cellArr;
@property (nonatomic,strong) NSString *strl;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"专辑";
    _tableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate =self;
    
    _tableview.rowHeight = UITableViewAutomaticDimension;
    _tableview.estimatedRowHeight = 44.0;
    
    [self.view addSubview:_tableview];
    [self addBackgroundView];
    
}

- (void)addBackgroundView{
    
    UIView *viewnew = [[UIView alloc] init];
    UIImageView *imag = [[UIImageView alloc] init];
    imag.frame = CGRectMake(0, 64, self.view.frame.size.width, (self.view.frame.size.height-100));
    imag.image = [UIImage imageNamed:@"new2"];
    [viewnew addSubview:imag];
    self.tableview.backgroundView = viewnew;
    
}

- (NSMutableArray *)cellArr
{
    if (_cellArr == nil) {
        _cellArr = [NSMutableArray array];
        [self loadidfromNet];
    }
    return _cellArr;
    

}


- (void)loadidfromNet{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameter = @{@"type":@"collection",
                                @"machine" : @"Oa91505e686314edd30e6409d5faad201b48366eb",
                                @"version" :@"11.6.2"};
    [manage POST:ID_URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       _strl= dic1[@"message"];
       // NSLog(@"%@",_strl);
        
        NSDictionary *parameter1 = @{@"recommendUriIds":_strl,
                                    @"machine" : @"Oa91505e686314edd30e6409d5faad201b48366eb",
                                    @"version" :@"11.6.2"};
        [manage POST:CELL_URL parameters:parameter1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"%@",responseObject);
           NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSArray *temp =dic[@"list"];
            for (NSDictionary *dict in temp) {
                Fourcell *celldata = [Fourcell dataWithDictionary:dict];
                [self.cellArr addObject:celldata];
            }
            [_tableview reloadData];
        } failure:nil];
 
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 
             }];
        
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *identify = @"cell";
   FourviewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"FourviewCell" owner:self options:nil][0];
    }
    Fourcell *celldata = self.cellArr[indexPath.row];
    cell.datacell = celldata;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TZFourViewController *TZF = [[TZFourViewController alloc]init];
    Fourcell *fourcell = self.cellArr[indexPath.row];
    [TZF setValue:fourcell forKey:@"fourcell"];
    //[TZF setValue:fourcell.ID forKey:@"ID"];
    [self.navigationController pushViewController:TZF animated:YES];
    
}
@end

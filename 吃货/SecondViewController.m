//
//  SecondViewController.m
//  吃货GOGOGO
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "SecondViewController.h"
#import "AFNetworking.h"
#import "Seconddata.h"
#import "NSString+GetUrl.h"
#import "ScondTableViewCell.h"
#import "MJRefresh.h"


#import "TZSecondViewController.h"


//点进去的url
#define CELL_URL @"http://www.ecook.cn/public/selectRecipeListByIdList.shtml"
/**
 全部请求下来的id
 */
#define ID_URL @"http://www.ecook.cn/public/selectLatestContentIdList.shtml"


@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *cellarr;
@property (nonatomic,strong) NSString *strl;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title =@"菜谱";
    _tableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    _tableview.rowHeight = UITableViewAutomaticDimension;
    _tableview.estimatedRowHeight = 44.0;

    _tableview.dataSource = self;
    _tableview.delegate = self;
    
    [self.view addSubview:_tableview];
    [self loadidfromNet];
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

- (NSMutableArray *)cellarr
{
    if (_cellarr == nil) {
        _cellarr = [NSMutableArray array];
    }
    return _cellarr;
}



- (void)loadidfromNet{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage GET:ID_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       
        NSArray *temp = dic1[@"list"];
        
       _strl = [temp componentsJoinedByString:@","];
        
        NSDictionary *parameter = @{@"ids":_strl,
                                    
                                    @"machine" : @"786f2ddeca9985d7c560811304108481",
                                    @"version" :@"11.6.2"};
   [manage POST:CELL_URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSArray *temp = dic1[@"list"];
      // NSLog(@"%@",temp);
            
            for (NSDictionary *dict in temp) {
                Seconddata *celldata = [Seconddata dataWithDictionary:dict];
                [self.cellarr addObject:celldata];
            }
       
       [self.tableview reloadData];
       
        }
         
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 
             }];
        
        

        
        
  } failure:nil];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    
   ScondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ScondTableViewCell" owner:self options:nil][0];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    NSLog(@"%@",cell);
    Seconddata *celldata = self.cellarr[indexPath.row];
    cell.secData = celldata;
   

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TZSecondViewController *TZS = [[TZSecondViewController alloc] init];
    
    Seconddata *data = self.cellarr[indexPath.row];
    [TZS setValue:data forKey:@"Seconddata"];
    [TZS setValue:data.ID forKey:@"ID"];

    
    [self.navigationController pushViewController:TZS animated:YES];
}



@end

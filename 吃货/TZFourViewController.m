//
//  TZFourViewController.m
//  吃货
//
//  Created by qingyun on 16/1/25.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TZFourViewController.h"
#import "AFNetworking.h"
#import "Fourcell.h"

#import "TZFourViewCell.h"
#import "FirstCelldate.h"

#import "Seconddata.h"
#import "ScondTableViewCell.h"

#import "TZSecondViewController.h"

#define TOP_Url @"http://www.ecook.cn/public/selectWeiboById.shtml"

#define ALLCELL_Url @"http://www.ecook.cn/public/getAllCollectionShareList.shtml"

#define CELL_URL @"http://www.ecook.cn/public/selectRecipeListByIdList.shtml"

@interface TZFourViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *TopArr;
@property (nonatomic,strong) NSMutableArray *CellArr;
@property (nonatomic,strong) Fourcell *fourcell;
@property (nonatomic,strong) NSString *topstrl;
@property (nonatomic,strong) NSString *cellstrl;

@end

@implementation TZFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 44.0f;
    [self.view addSubview:_tableview];
    [self datelodeFormNet];
    [self addBackItem];
    self.title = self.fourcell.title;
    
    
}
-(void)addBackItem{
//设置左边的barButtonItem
UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtnClick)];
self.navigationItem.leftBarButtonItem = leftBarBtnItem;

}
- (void)leftBarBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)TopArr
{
    if (_TopArr == nil) {
        _TopArr = [NSMutableArray array];
    }
    return _TopArr;
}

- (NSMutableArray *)CellArr
{
    if (_CellArr == nil) {
        _CellArr = [NSMutableArray array];
    }
    return _CellArr;
}


- (void)datelodeFormNet{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
  
    NSDictionary *parameters = @{@"ids":self.fourcell.ID,
                                 @"machine":@"786f2ddeca9985d7c560811304108481",
                                 @"version":@"11.6.2"
                                 };
    [manage POST:ALLCELL_Url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",dict);
        NSArray *temp = dict[@"list"];
        for (NSDictionary *dic in temp) {
           _cellstrl = dic[@"recipeididlist"];
           _topstrl = dic[@"wid"];
            
        NSDictionary *parameters = @{@"id":_topstrl,
                               @"machine":@"786f2ddeca9985d7c560811304108481",
                                @"version":@"11.6.2"
                                         };

        [manage POST:TOP_Url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            FirstCelldate *data = [FirstCelldate dataWithDictionary:dic1];
            [self.TopArr addObject:data];
            [_tableview reloadData];
        } failure:nil];
         
            
        
            NSDictionary *parameter1 = @{@"ids":_cellstrl,
                                        
                                        @"machine" : @"786f2ddeca9985d7c560811304108481",
                                        @"version" :@"11.6.2"};
        [manage POST:CELL_URL parameters:parameter1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
           // NSLog(@"%@",dic2);
            NSArray *temp = dic2[@"list"];
            NSLog(@"%@",temp);
            for (NSDictionary *dict in temp) {
                Seconddata *celldata = [Seconddata dataWithDictionary:dict];
                [self.CellArr addObject:celldata];
            }
            
            [self.tableview reloadData];
            
        } failure:nil];
        
      }
        
        
    } failure:nil];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.TopArr.count;
            break;
            
        default:
            break;
    }
    return self.CellArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString *identify =@"topcell";
            TZFourViewCell *topcell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (topcell == nil) {
                topcell = [[NSBundle mainBundle]loadNibNamed:@"TZFourViewCell" owner:self options:nil][0];
                FirstCelldate *data = self.TopArr[indexPath.row];
                topcell.data = data;
            
                
            }
            return topcell;
            break;
        }
      case 1:
        {
            static NSString *identify = @"cell";
            
            ScondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"ScondTableViewCell" owner:self options:nil][0];
                cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            }
            NSLog(@"%@",cell);
            Seconddata *celldata = self.CellArr[indexPath.row];
            cell.secData = celldata;
            
            
            return cell;
        }
            
       break;
        default:
            break;
    }
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        
            break;
        case 1:{
            TZSecondViewController *TZS = [[TZSecondViewController alloc] init];
            
            Seconddata *data = self.CellArr[indexPath.row];
            [TZS setValue:data forKey:@"Seconddata"];
            [TZS setValue:data.ID forKey:@"ID"];
            
            
            [self.navigationController pushViewController:TZS animated:YES];

        }
            break;
        default:
            break;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            
            break;
        case 1:{
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 50, 10)];
            lab.text = @"专辑精选";
            return lab;
        }
            break;
            
        default:
            break;
    }
    return nil;
    }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1.0;
            break;
            
        default:
            break;
    }
    return 0;
}


@end

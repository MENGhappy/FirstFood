//
//  TZThirdViewController.m
//  吃货
//
//  Created by qingyun on 16/1/21.
//  Copyright © 2016年 河南青云. All rights reserved.
//


/**第一页第三页跳转页面*/
#import "TZThirdViewController.h"
#import "TZCelldata.h"
#import "AFNetworking.h"
#import "FirstCelldate.h"

#import "TZFirstTableViewCell.h"
#import "TZTableViewCell.h"
#import "UIImageView+WebCache.h"



//点进去的url

#define CELL_URL @"http://www.ecook.cn/public/selectCommentByCidInFloor.shtml"



@interface TZThirdViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arr;
/** string 微博ID*/
@property (nonatomic ,strong) NSString *firstID;
/** string 昵称*/
@property (nonatomic, strong) NSString *nickName;
/** FirstCelldate 微博模型*/
@property (nonatomic, strong) FirstCelldate *firstCellData;

@end

@implementation TZThirdViewController

- (NSMutableArray *)arr {
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    
    _tableview.estimatedRowHeight = 44.0;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:_tableview];
    self.title = self.firstCellData.title;
    [self loaddataforNet];
  
}

- (void)loaddataforNet{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameter = @{@"mid":_firstID,
                                @"machine" : @"786f2ddeca9985d7c560811304108481",
                                @"sort":@"asc",
                                @"version" :@"11.6.2",
                                @"page":@"1"
                                };
    [manage POST:CELL_URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"%@",responseObject);
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"%@",dic1);
        
        NSArray *temp = dic1[@"list"];
        for (NSDictionary *dict in temp) {
            TZCelldata *celldata = [TZCelldata dataWithDictionary:dict];
            if ([self.firstCellData.nickname isEqualToString:dict[@"musername"]]) {
                
                [self.arr addObject:celldata];
            }
            
        }
        [self.tableview reloadData];
        

     
        
    
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
         }];
    
    
    
}

//分组
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    return 2;
}




//组中的cell
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.arr.count;
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
       switch (indexPath.section) {
        case 0:
           {
               static NSString *identify =@"cellnew";
               TZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
               if (cell == nil) {
                   cell = [[NSBundle mainBundle]loadNibNamed:@"TZTableViewCell"owner:self options:nil][0];
                   
                   cell.label.text = self.firstCellData.weibo;
                   
                   [cell.image sd_setImageWithURL:[NSURL URLWithString:self.firstCellData.url] placeholderImage:[UIImage imageNamed:@"Img_default"]];
               
               }
               return cell;
           }
            break;
        case 1:
            {
                
            static NSString *identify =@"cell1";
            TZFirstTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell1 == nil) {
                cell1 = [[NSBundle mainBundle]loadNibNamed:@"TZFirstTableViewCell" owner:self options:nil][0];
                
              }
            TZCelldata *celldata = self.arr[indexPath.row];
            cell1.celldata = celldata;
            
            return cell1;
            
        }
            
            break;
        default:
            break;
    }
    
  return nil;
}






@end

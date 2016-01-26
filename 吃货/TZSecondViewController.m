//
//  TZSecondViewController.m
//  吃货
//
//  Created by qingyun on 16/1/22.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TZSecondViewController.h"
#import "Seconddata.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "TZTableViewCell.h"
#import "TZSecondViewController.h"
#import "TZsecondcell.h"

#import "TZsecondTableViewCell.h"
#import "TZsecondcell.h"

#import "TZsecond.h"
#import "TZsecondtabCell.h"


#define CELL_NEW @"http://www.ecook.cn/public/selectRecipeListByIdList.shtml"

@interface TZSecondViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSString *ID;

@property (nonatomic,strong) Seconddata *Seconddata;
@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *arr;

@property (nonatomic,strong) NSMutableArray *arrnew;

@end

@implementation TZSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    
    _tableview.estimatedRowHeight = 44.0;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    
    self.title = self.Seconddata.Name;
   [self.view addSubview:_tableview];
    [self addBackItem];
    [self loaddata];
   

  
}
-(void)addBackItem{
    //设置左边的barButtonItem
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtnClick)];
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    
}
- (void)leftBarBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

- (NSMutableArray *)arrnew
{
    if (_arrnew == nil) {
        _arrnew = [NSMutableArray array];
    }
    return _arrnew;
}


//网络请求
-(void)loaddata{
    
    AFHTTPSessionManager *manage1 = [AFHTTPSessionManager manager];
    //响应序列化
    manage1.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    

    NSDictionary *parameter = @{@"ids":_ID,
                                
                                @"machine" : @"Oa91505e686314edd30e6409d5faad201b48366eb",
                                @"version" :@"11.6.2"};
    [manage1 POST:CELL_NEW parameters:parameter constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //NSLog(@"%@",responseObject);
         NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       // NSLog(@"%@",dic1);
        NSArray *temp = dic1[@"list"];
       //NSLog(@"%@",temp);
        for (NSDictionary *dict in temp) {
            
            NSArray *cellarr = dict[@"stepList"];
            for (NSDictionary *dic in cellarr) {
                TZsecondcell *data = [TZsecondcell dataWithDictionary:dic];
               // NSLog(@"data%@",data);
                [self.arr addObject:data];
            }
            
            NSArray *cellarr1 = dict[@"materialList"];
            for (NSDictionary *dic1 in cellarr1) {
            TZsecond *data1 = [TZsecond dataWithDictionary:dic1];
                //NSLog(@"data1%@",data1);
                [self.arrnew addObject:data1];
                
            }
            
        }
       [self.tableview reloadData];

        
    } failure:nil];
    
}
//分组
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    return 3;
}



//组中的cell
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.arrnew.count;
            break;
        case 2:
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
            static NSString *identify =@"cell1";
            TZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"TZTableViewCell"owner:self options:nil][0];
                cell.label.text = self.Seconddata.content;
                [cell.image sd_setImageWithURL:[NSURL URLWithString:self.Seconddata.imgUrl1] placeholderImage:[UIImage imageNamed:@"Img_default"]];
               
            }
            return cell;
            break;
        }
        case 1:
        {
            static NSString *identify =@"cellnew";
            TZsecondtabCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell1 == nil) {
                cell1 = [[NSBundle mainBundle]loadNibNamed:@"TZsecondtabCell"owner:self options:nil][0];
                TZsecond *celldatanew = self.arrnew[indexPath.row];
                cell1.data = celldatanew;
                
            }
            return cell1;
            break;
        }
        case 2:
        {
          static NSString *identify =@"cell";
           TZsecondTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell2 == nil) {
                cell2 = [[NSBundle mainBundle]loadNibNamed:@"TZsecondCell"owner:self options:nil][0];
               TZsecondcell *celldata = self.arr[indexPath.row];
                cell2.datacell = celldata;
               
            }
            return cell2;
            break;
        }
        default:
            break;
    }
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 30;
            break;
            
        case 2:
            return 30;
            break;
        default:
            break;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            
            break;
            case 1:
        {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 50, 10)];
            lab.text = @"材料:";
            return lab;
            break;
        }
            case 2:
        {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 50, 10)];
            lab.text = @"做法:";
            return lab;
        }
            break;
            
            
            
        default:
            break;
    }
    return nil;
}



@end

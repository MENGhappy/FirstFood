//
//  TZFirstTableViewCell.h
//  吃货
//
//  Created by qingyun on 16/1/22.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TZCelldata;

@interface TZFirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UILabel *labes;

@property (nonatomic,strong) TZCelldata *celldata;

@end

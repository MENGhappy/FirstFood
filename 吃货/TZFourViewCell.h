//
//  TZFourViewCell.h
//  吃货
//
//  Created by qingyun on 16/1/25.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirstCelldate;

@interface TZFourViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *weboLbel;

@property (nonatomic,strong) FirstCelldate *data;
@end

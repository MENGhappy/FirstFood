//
//  FourviewCell.h
//  吃货
//
//  Created by qingyun on 16/1/24.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Fourcell;

@interface FourviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagefour;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (nonatomic,strong) Fourcell *datacell;

@end

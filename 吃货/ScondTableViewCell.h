//
//  ScondTableViewCell.h
//  吃货
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  Seconddata;

@interface ScondTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Name;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (nonatomic,strong) Seconddata *secData;

@property (weak, nonatomic) IBOutlet UILabel *LabelZFname;
@end

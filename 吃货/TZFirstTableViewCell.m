//
//  TZFirstTableViewCell.m
//  吃货
//
//  Created by qingyun on 16/1/22.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TZFirstTableViewCell.h"
#import "TZCelldata.h"
#import "UIImageView+WebCache.h"

@implementation TZFirstTableViewCell

- (void)setCelldata:(TZCelldata *)celldata
{
    _celldata = celldata;
   [_images sd_setImageWithURL:[NSURL URLWithString:celldata.imgUrl] placeholderImage:[UIImage imageNamed:@"new3"]];
    self.labes.text = celldata.content;
       
}


- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end

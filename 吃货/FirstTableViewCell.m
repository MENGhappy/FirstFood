//
//  HMTableViewCell.m
//  吃货GOGOGO
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "FirstTableViewCell.h"

#import "FirstCelldate.h"

#import "UIImageView+WebCache.h"


@implementation FirstTableViewCell

/**重写cell的set方法*/
- (void)setCelldata:(FirstCelldate *)celldata
{
    self.nameLabel.text = celldata.nickname;
    self.titleLabel.text = celldata.weibo;
    self.dayLabel.text = celldata.title;
    
    [_HMimage sd_setImageWithURL:[NSURL URLWithString:celldata.url] placeholderImage:[UIImage imageNamed:@"new3.png"]];
    _headerView.layer.masksToBounds = YES;
    _headerView.layer.cornerRadius = 25;
    [_headerView sd_setImageWithURL:[NSURL URLWithString:celldata.imaUrl] placeholderImage:[UIImage imageNamed:@"Img_default"]];
    
    
}

- (void)awakeFromNib {
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

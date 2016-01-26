//
//  TZFourViewCell.m
//  吃货
//
//  Created by qingyun on 16/1/25.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TZFourViewCell.h"
#import "UIImageView+WebCache.h"
#import "FirstCelldate.h"

@implementation TZFourViewCell

- (void)setData:(FirstCelldate *)data
{
    _data = data;
    self.topImage .layer.masksToBounds = YES;
    self.topImage.layer.cornerRadius = 62;
    self.topImage.layer.borderWidth = 4.0;
    self.topImage.layer.borderColor = [[UIColor whiteColor]CGColor];
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:data.url] placeholderImage:[UIImage imageNamed:@"avatar180"]];
    self.nameLabel.text = data.nickname;
    self.weboLbel.text = data.weibo;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ScondTableViewCell.m
//  吃货
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "ScondTableViewCell.h"
#import "Seconddata.h"
#import "UIImageView+WebCache.h"


@implementation ScondTableViewCell
- (void)setSecData:(Seconddata *)secData
{
    _secData = secData;
    
  [self.image sd_setImageWithURL:[NSURL URLWithString:secData.imgUrl1] placeholderImage:[UIImage imageNamed:@"new1"]];
    

    self.Name.text = secData.Name;
    self.LabelZFname.text = secData. content;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

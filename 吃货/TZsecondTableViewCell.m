//
//  TZsecondTableViewCell.m
//  吃货
//
//  Created by qingyun on 16/1/23.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TZsecondTableViewCell.h"

#import "UIImageView+WebCache.h"
#import "TZsecondcell.h"

@implementation TZsecondTableViewCell

- (void)setDatacell:(TZsecondcell *)datacell
{
    _datacell = datacell;
    [_ZFimage sd_setImageWithURL:[NSURL URLWithString:datacell.imageidurl] placeholderImage:[UIImage imageNamed:@"new1"]];
    self.ZFlabel.text = datacell.details;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

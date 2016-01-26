//
//  FourviewCell.m
//  吃货
//
//  Created by qingyun on 16/1/24.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "FourviewCell.h"
#import "Fourcell.h"
#import "UIImageView+WebCache.h"

@implementation FourviewCell

- (void)setDatacell:(Fourcell *)datacell
{
    _datacell = datacell;
    [self.imagefour sd_setImageWithURL:[NSURL URLWithString:datacell.imageUrl] placeholderImage:[UIImage imageNamed:@"new1"]];
    self.label1.text = datacell.title;
    self.label2.text = datacell.author;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  TZsecondtabCell.m
//  吃货
//
//  Created by qingyun on 16/1/24.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TZsecondtabCell.h"
#import "TZsecond.h"

@implementation TZsecondtabCell

- (void)setData:(TZsecond *)data
{
    _data = data;
    self.label.text = data.name;
    self.label2.text = data.dosage;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

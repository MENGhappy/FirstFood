//
//  TZsecondTableViewCell.h
//  吃货
//
//  Created by qingyun on 16/1/23.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TZsecondcell;

@interface TZsecondTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *ZFlabel;
@property (weak, nonatomic) IBOutlet UIImageView *ZFimage;
@property (nonatomic,strong) TZsecondcell *datacell;
@end

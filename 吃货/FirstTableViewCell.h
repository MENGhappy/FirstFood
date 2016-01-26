//
//  HMTableViewCell.h
//  吃货GOGOGO
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 河南青云. All rights reserved.
//

/**第一页第三页cell用的*/
#import <UIKit/UIKit.h>

@class FirstCelldate;

@interface FirstTableViewCell : UITableViewCell

/**作者照片*/
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
/**作者名字*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**菜名*/
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
/**菜品介绍*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**菜品大图*/
@property (weak, nonatomic) IBOutlet UIImageView *HMimage;

/**暂时启用*/
@property (weak, nonatomic) IBOutlet UIButton *DZbtn;
@property (weak, nonatomic) IBOutlet UIButton *PLbtn;
@property (weak, nonatomic) IBOutlet UIButton *FXbtn;
@property (weak, nonatomic) IBOutlet UIView *lowView;


/**引进模型*/
@property (nonatomic,strong) FirstCelldate *celldata;

@end

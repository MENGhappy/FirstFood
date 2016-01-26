//
//  Celldate.h
//  吃货GOGOGO
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstCelldate : NSObject
/**作者名字*/
@property (nonatomic,strong) NSString *nickname;
/**菜品名字*/
@property (nonatomic,strong) NSString *title;
/**菜品介绍*/
@property (nonatomic,strong) NSString *weibo;
/**作者照片*/
@property (nonatomic,strong) NSString *imaUrl;
/**跳转标示跳转的参数*/
@property (nonatomic,strong) NSString *firstID;

@property (nonatomic,strong) NSString *usercontent;
/**菜品大图*/
@property (nonatomic,strong) NSString *url;


- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)dataWithDictionary:(NSDictionary *)dict;



@end

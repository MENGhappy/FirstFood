//
//  HOMETopData.h
//  chibafang_v1.4
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 轮播图的模型
 */
@interface FirstTopData : NSObject
/**
 图片的url
 */
@property (nonatomic, strong) NSString *imageid;
/**
 点击响应的url
 */
@property (nonatomic, strong) NSString *url;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)dataWithDictionary:(NSDictionary *)dict;

@end

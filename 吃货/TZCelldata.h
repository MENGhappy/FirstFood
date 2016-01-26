//
//  TZCelldata.h
//  吃货
//
//  Created by qingyun on 16/1/22.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TZCelldata : NSObject
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *content;

@property (nonatomic,strong) NSString *musername;


- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)dataWithDictionary:(NSDictionary *)dict;



@end

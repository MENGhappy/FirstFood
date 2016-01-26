//
//  TZsecond.h
//  吃货
//
//  Created by qingyun on 16/1/24.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZsecond : NSObject

@property (nonatomic,strong) NSString *dosage;
@property (nonatomic,strong) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)dataWithDictionary:(NSDictionary *)dict;



@end

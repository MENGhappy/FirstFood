//
//  Seconddata.h
//  吃货
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Seconddata : NSObject

@property (nonatomic,strong) NSString *imgUrl1;
@property (nonatomic,strong) NSString *Name;
@property (nonatomic,strong) NSString * content;

@property (nonatomic,strong) NSString *editname;

@property (nonatomic,strong) NSString *ID;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)dataWithDictionary:(NSDictionary *)dict;


@end

//
//  Fourcell.h
//  吃货
//
//  Created by qingyun on 16/1/24.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fourcell : NSObject

@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *ID;


- (instancetype)initWithDictionary:(NSDictionary*)dict;
+ (instancetype)dataWithDictionary:(NSDictionary*)dict;

@end

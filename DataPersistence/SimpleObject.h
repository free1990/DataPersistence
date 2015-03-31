//
//  SimpleObject.h
//  DataPersistence
//
//  Created by John on 15/3/31.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SimpleObject : NSObject<NSCopying>

@property (nonatomic, strong)         NSString *name;
@property (nonatomic, assign)         NSInteger age;
@property (nonatomic, strong)         NSString *address;
@property (nonatomic, strong)         UIImage *photo;

@property (nonatomic, strong)         NSArray *normalData;

@property (nonatomic, strong)         NSArray *recombinationData;

@end

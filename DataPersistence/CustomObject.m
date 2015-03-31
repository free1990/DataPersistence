//
//  CsustomObject.m
//  DataPersistence
//
//  Created by John on 15/3/31.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "CustomObject.h"

#define kNameKey @"NameKey"
#define kAgeKey @"AgeKey"

@implementation CustomObject

@synthesize name = _name;
@synthesize age = _age;

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:kNameKey];
    [aCoder encodeInteger:_age forKey:kAgeKey];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:kNameKey];
        _age = [aDecoder decodeIntForKey:kAgeKey];
    }
    return self;
}

#pragma mark - NSCoping
- (id)copyWithZone:(NSZone *)zone {
    CustomObject *copy = [[[self class] allocWithZone:zone] init];
    copy.name = [self.name copyWithZone:zone];
    copy.age = self.age;
    return copy;
}


@end

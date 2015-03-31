//
//  SimpleObject.m
//  DataPersistence
//
//  Created by John on 15/3/31.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "SimpleObject.h"

#define kNameKey @"NameKey"
#define kAgeKey @"AgeKey"
#define kAddress @"AddressKey"
#define kPhotoKey @"PhotoKey"
#define kNormalDataKey @"NormalDataKey"
#define kRecombinationDataKey @"RecombinationDataKey"

@implementation SimpleObject

@synthesize name = _name;
@synthesize age = _age;
@synthesize address = _address;
@synthesize photo = _photo;
@synthesize normalData = _normalData;
@synthesize recombinationData = _recombinationData;

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:kNameKey];
    [aCoder encodeInteger:_age forKey:kAgeKey];
    [aCoder encodeObject:_address forKey:kAddress];
    [aCoder encodeObject:_photo forKey:kPhotoKey];
    [aCoder encodeObject:_normalData forKey:kNormalDataKey];
    [aCoder encodeObject:_recombinationData forKey:kRecombinationDataKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:kNameKey];
        _age = [aDecoder decodeIntegerForKey:kAgeKey];
        _address = [aDecoder decodeObjectForKey:kAddress];
        _photo = [aDecoder decodeObjectForKey:kPhotoKey];
        _normalData = [aDecoder decodeObjectForKey:kNormalDataKey];
        _recombinationData = [aDecoder decodeObjectForKey:kRecombinationDataKey];
    }
    return self;
}

#pragma mark - NSCoping
- (id)copyWithZone:(NSZone *)zone {
    SimpleObject *copy = [[[self class] allocWithZone:zone] init];
    copy.name = [self.name copyWithZone:zone];
    copy.age = self.age;
    copy.address = [self.address copyWithZone:zone];
    copy.photo = self.photo;
    copy.normalData = self.normalData;
    copy.recombinationData = self.normalData;
    return copy;
}

@end

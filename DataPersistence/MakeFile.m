//
//  MakeFile.m
//  DataPersistence
//
//  Created by John on 15/4/9.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "MakeFile.h"

@implementation MakeFile

- (NSString *)dataPath:(NSString *)file
{
    
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"badge"];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    
    NSString *result = [path stringByAppendingPathComponent:file];
    
    return result;
    
}

- (void)bengin
{
    //此处首先指定了图片存取路径（默认写到应用程序沙盒 中）
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //并给文件起个文件名
    NSString *imageDir = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"163"] stringByAppendingPathComponent:@"songzi"];
    
    //存放图片的文件夹
    NSString *imagePath =[imageDir stringByAppendingPathComponent:@"0.png"];
    
    NSData *data = nil;
    
//    //检查图片是否已经保存到本地
//    if([self isExistsFile:imagePath]){
//        data=[NSData dataWithContentsOfFile:imagePath];
//    }else{
//        data = [NSData dataWithContentsOfURL:[NSURL URLWithString: @"http://211.154.154.96:7071/press/163/songzi/0.jpg"]];
//        
//        //创建文件夹路径
//        [[NSFileManager defaultManager] createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
//        
//        //创建图片
//        [UIImagePNGRepresentation([UIImage imageWithData:data]) writeToFile:imagePath atomically:YES];
//    }
//    imageView.image = [UIImage imageWithData:data];
}

@end

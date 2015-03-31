//
//  ViewController.m
//  DataPersistence
//
//  Created by John on 15/3/31.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ViewController.h"
#import "SimpleObject.h"
#import "CustomObject.h"

#define kArchivingDataKey @"ArchivingDataKey"

@interface ViewController ()

@property (nonatomic, strong) NSString *archiving;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [save setFrame:CGRectMake(100, 50, 100, 50)];
    [save setTitle:@"save" forState:UIControlStateNormal];
    [save setBackgroundColor:[UIColor blueColor]];
    [save addTarget:self action:@selector(saveObject) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:save];
    
    UIButton *read = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [read setFrame:CGRectMake(100, 150, 100, 50)];
    [read setTitle:@"read" forState:UIControlStateNormal];
    [read setBackgroundColor:[UIColor blueColor]];
    [read addTarget:self action:@selector(readObject) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:read];
    
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* fileName = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"DataCnter"];
    
    self.archiving = fileName;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    self.imageView.center = self.view.center;
    self.imageView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.imageView];
}

- (void)saveObject
{
    NSString *name = @"John";
    NSInteger age = 24;
    NSString *address = @"路上";

    UIImage *photo = [UIImage imageWithCGImage:[UIImage imageNamed:@"test"].CGImage
                                         scale:[UIImage imageNamed:@"test"].scale
                                   orientation:[UIImage imageNamed:@"test"].imageOrientation];;
    
    //存储数据到类
    SimpleObject *archivingData = [[SimpleObject alloc] init];
    archivingData.name = name;
    archivingData.age = age;
    archivingData.address = address;
    archivingData.photo = photo;
    archivingData.normalData = [[NSArray alloc] initWithObjects:@1, @2, nil];
    
    CustomObject *object1 = [[CustomObject alloc] init];
    
    object1.name =  NSStringFromClass([object1 class]);
    object1.age = 10;
    
    CustomObject *object2 = [[CustomObject alloc] init];
    
    object2.name = NSStringFromClass([object2 class]);
    object2.age = 11;
    
    archivingData.recombinationData = [[NSArray alloc] initWithObjects:object1, object2, nil];
    
    //归档
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:archivingData forKey:kArchivingDataKey];
    
    //方法被调用
    [archiver finishEncoding];
    //写入文件
    [data writeToFile:self.archiving atomically:YES];
}

- (void)readObject
{
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:self.archiving];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    //获得类
    SimpleObject *archivingData = [unarchiver decodeObjectForKey:kArchivingDataKey];// initWithCoder方法被调用
    [unarchiver finishDecoding];
    
    //读取的数据
    NSString *name = archivingData.name;
    NSInteger age = archivingData.age;
    NSString *address = archivingData.address;
    
    self.imageView.image = archivingData.photo;
    
    NSArray *temp = archivingData.normalData;
    
    for (CustomObject *obj in archivingData.recombinationData){
        
        NSLog(@"name ==  %@", obj.name);
        NSLog(@"---->   %d", obj.age);
    }
    
    NSLog(@"temp count = %ld, index 1 = %@", [temp count], [temp objectAtIndex:1]);
    
    NSLog(@"self.imageView.image = %@ width = %f, height = %f , malloc size = %ld", self.imageView.image, self.imageView.image.size.width, self.imageView.image.size.height, sizeof(self.imageView.image));
    
    NSLog(@"%@||%ld||%@",name,age,address);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

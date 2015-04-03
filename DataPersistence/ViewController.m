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
    
    [self listAllLocalFiles];
}

//list all the files exists in Document Folder in our Sandbox.
- (void)listAllLocalFiles
{
    // Fetch directory path of document for local application.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // NSFileManager is the manager organize all the files on device.
    NSFileManager *manager = [NSFileManager defaultManager];
    // This function will return all of the files' Name as an array of NSString.
    NSArray *files = [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    // Log the Path of document directory.
    NSLog(@"Directory: %@", documentsDirectory);
    // For each file, log the name of it.
    for (NSString *file in files) {
        NSLog(@"File at: %@", file);
    }
}

//Create a File in the Document Folder.
- (void)createFileWithName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    // 1st, This funcion could allow you to create a file with initial contents.
    // 2nd, You could specify the attributes of values for the owner, group, and permissions.
    // Here we use nil, which means we use default values for these attibutes.
    // 3rd, it will return YES if NSFileManager create it successfully or it exists already.
    if ([manager createFileAtPath:filePath contents:nil attributes:nil]) {
        NSLog(@"Created the File Successfully.");
    } else {
        NSLog(@"Failed to Create the File");
    }
}

//Delete a File in the Document Folder.
- (void)deleteFileWithName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    // Need to check if the to be deleted file exists.
    if ([manager fileExistsAtPath:filePath]) {
        NSError *error = nil;
        // This function also returnsYES if the item was removed successfully or if path was nil.
        // Returns NO if an error occurred.
        [manager removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
    } else {
        NSLog(@"File %@ doesn't exists", fileName);
    }
}

//Rename a File in the Document Folder.
- (void)renameFileWithName:(NSString *)srcName toName:(NSString *)dstName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePathSrc = [documentsDirectory stringByAppendingPathComponent:srcName];
    NSString *filePathDst = [documentsDirectory stringByAppendingPathComponent:dstName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePathSrc]) {
        NSError *error = nil;
        [manager moveItemAtPath:filePathSrc toPath:filePathDst error:&error];
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
    } else {
        NSLog(@"File %@ doesn't exists", srcName);
    }
}


//Read a File in the Document Folder.
/* This function read content from the file named fileName.
 */
- (void)readFileWithName:(NSString *)fileName
{
    // Fetch directory path of document for local application.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    // NSFileManager is the manager organize all the files on device.
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        // Start to Read.
        NSError *error = nil;
        NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSStringEncodingConversionAllowLossy error:&error];
        NSLog(@"File Content: %@", content);
        
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
    } else {
        NSLog(@"File %@ doesn't exists", fileName);
    }
}

//Write a File in the Document Folder.
/* This function Write "content" to the file named fileName.
 */
- (void)writeString:(NSString *)content toFile:(NSString *)fileName
{
    // Fetch directory path of document for local application.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    // NSFileManager is the manager organize all the files on device.
    NSFileManager *manager = [NSFileManager defaultManager];
    // Check if the file named fileName exists.
    if ([manager fileExistsAtPath:filePath]) {
        NSError *error = nil;
        // Since [writeToFile: atomically: encoding: error:] will overwrite all the existing contents in the file, you could keep the content temperatorily, then append content to it, and assign it back to content.
        // To use it, simply uncomment it.
        //        NSString *tmp = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:NSStringEncodingConversionAllowLossy error:nil];
        //        if (tmp) {
        //            content = [tmp stringByAppendingString:content];
        //        }
        // Write NSString content to the file.
        [content writeToFile:filePath atomically:YES encoding:NSStringEncodingConversionAllowLossy error:&error];
        // If error happens, log it.
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
    } else {
        // If the file doesn't exists, log it.
        NSLog(@"File %@ doesn't exists", fileName);
    }
    
    // This function could also be written without NSFileManager checking on the existence of file,
    // since the system will atomatically create it for you if it doesn't exist.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  FileManager
//
//  Created by Zohair Hemani on 21/10/2014.
//  Copyright (c) 2014 Zohair Hemani. All rights reserved.
//

#import "FileManagerLibrary.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [ViewController createDirForImage:@"harrypotter" :@"/zohairhemani"];
    [self directoryContents:@"/zohairhemani"];
    
    //App Directory & Directory Contents
    

    
}

-(NSArray*) directoryContents: (NSString*) atPath
{
   
    NSString *appFolderPath = [[self applicationDocumentsDirectory].path stringByAppendingString:atPath]; // append path of the folder here.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSLog(@"App Directory is: %@", appFolderPath);
    NSArray *dirContents = [[NSArray alloc]initWithObjects:[fileManager contentsOfDirectoryAtPath:appFolderPath error:nil], nil];
    NSLog(@"Directory Contents:\n%@", dirContents);
    
    return dirContents;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(void)createDirForImage :(NSString *)dirName : (NSString*) inFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    BOOL isDirectory;
    NSString *yoyoDir = [[[paths objectAtIndex:0] stringByAppendingString:inFolder] stringByAppendingPathComponent:dirName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:yoyoDir isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
        [[NSFileManager defaultManager] createDirectoryAtPath:yoyoDir
           withIntermediateDirectories:YES
                            attributes:attr
                                 error:&error];
        if (error){
            NSLog(@"Error creating directory path: %@", [error localizedDescription]);
        }
    }
}


- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}



@end

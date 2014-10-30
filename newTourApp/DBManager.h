//
//  DBManager.h
//  newTourApp
//
//  Created by Avialdo on 30/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
    
}

@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic, strong) NSMutableArray *arrResults;

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveData:(NSString*)imageName comments:(NSString*)comments
      category:(NSString*)category userID:(NSString*)userID isSync:(int)isSync;
-(NSArray*) findByUserID:(NSString*)userID Sync:(int)sync Category:(NSString *) category;

@end
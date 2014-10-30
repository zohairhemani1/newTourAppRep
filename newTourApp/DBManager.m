//
//  DBManager.m
//  newTourApp
//
//  Created by Avialdo on 30/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import "DBManager.h"

//singleton Pattern
static DBManager *sharedInstance = nil;

static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;


@implementation DBManager

+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB{
    
    // NSLog(@"Entered in the method");
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"tour.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "create table if not exists sync (id integer, image_name text, category text, comment text, user_id text, is_sync integer)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

-(BOOL) saveData:(NSString*)imageName comments:(NSString*)comments
        category:(NSString*)category userID:(NSString*)userID isSync:(int)isSync
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into sync (id,image_name, category, comment,user_id,is_sync) values (\"%d\",\"%@\", \"%@\", \"%@\",\"%@\",\"%d\")",1, imageName, category, comments,userID,isSync];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

-(NSArray*) findByUserID:(NSString*)userID Sync:(int)sync Category:(NSString *) category
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = @"select image_name, category, comment from sync where 1=1 ";
        
        if(userID !=nil){
            querySQL = [querySQL stringByAppendingString:[NSString stringWithFormat:@"and user_id = \"%@\"",userID]];
        }
        
        if(category !=nil){
            querySQL = [querySQL stringByAppendingString:[NSString stringWithFormat:@"and category = \"%@\"",category]];
        }
        
        if(sync != -1){
            querySQL = [querySQL stringByAppendingString:[NSString stringWithFormat:@"and is_sync = \"%d\"",sync]];
        }
        NSLog(@"the query is %@",querySQL);
        
        const char *query_stmt = [querySQL UTF8String];
       
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            if (self.arrResults != nil) {
                [self.arrResults removeAllObjects];
                self.arrResults = nil;
            }
            self.arrResults = [[NSMutableArray alloc] init];
            
            // Initialize the column names array.
            if (self.arrColumnNames != nil) {
                [self.arrColumnNames removeAllObjects];
                self.arrColumnNames = nil;
            }
            self.arrColumnNames = [[NSMutableArray alloc] init];
            
            // Declare an array to keep the data for each fetched row.
            NSMutableArray *arrDataRow;
            
            // Loop through the results and add them to the results array row by row.
            while(sqlite3_step(statement) == SQLITE_ROW){
                
                // Initialize the mutable array that will contain the data of a fetched row.
                arrDataRow = [[NSMutableArray alloc] init];
                
                // Get the total number of columns.
                int totalColumns = sqlite3_column_count(statement);
                
                // Go through all columns and fetch each column data.
                for (int i=0; i<totalColumns; i++){
                    // Convert the column data to text (characters).
                    char *dbDataAsChars = (char *)sqlite3_column_text(statement, i);
                    
                    // If there are contents in the currenct column (field) then add them to the current row array.
                    if (dbDataAsChars != NULL) {
                        // Convert the characters to string.
                        [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                        NSLog(@"value: %@",[NSString  stringWithUTF8String:dbDataAsChars]);
                    }
                    
                    // Keep the current column name.
                    if (self.arrColumnNames.count != totalColumns) {
                        dbDataAsChars = (char *)sqlite3_column_name(statement, i);
                        [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                    }
                }
                
                // Store each fetched data row in the results array, but first check if there is actually data.
                if (arrDataRow.count > 0) {
                    [self.arrResults addObject:arrDataRow];
                }
            }
            
            sqlite3_finalize(statement);
        }
    }
    return nil;
}
@end
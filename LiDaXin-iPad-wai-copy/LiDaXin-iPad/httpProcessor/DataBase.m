//
//  DataBase.m
//  LiDaXin-iPad
//
//  Created by zheng wanxiang on 12-9-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataBase.h"

static NSString* dbFileName = @"data.sqlite3";


@implementation DataBase

+(RoomTableObj*) GetSingleRoomTableObj
{
    
    static RoomTableObj* obj = nil;
    if (!obj) {
        obj = [[RoomTableObj alloc] init];
    }
    return obj;
}

//创建数据库
+(sqlite3*) createDB
{
    sqlite3* database = nil;
    @try {
        if (sqlite3_open([[[DataProcess getMainPath] stringByAppendingPathComponent:dbFileName] UTF8String], &database) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0,@"创建数据库文件失败！");
            NSLog(@"创建数据库文件失败！");
            return nil;
        }
        NSString* sql = nil;
        char* message;
        
        static bool bCreateRoom = false;
        if (!bCreateRoom) {
             sql = [NSString stringWithFormat:@"create table if not exists roomtable(roomid text,roomname text,hallid text,primary key (roomid))"];
            // @"create table if not exists statversion(row integer primary key,db_statversion text);";
            
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建roomtable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateRoom = true;
        }
        
        static bool bCreateImage = false;
        if (!bCreateImage) {
            
            sql = [NSString stringWithFormat:@"create table if not exists imagetable(imageid text,imageurl text,roomid text,description text,versionid text,primary key (imageid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建imagetable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateImage = true;
        }

               
        static bool bCreatePos = false;
        if (!bCreatePos) {

            sql = [NSString stringWithFormat:@"create table if not exists postable(posid text,posx text,posy text,bulbid text,imageid text,versionid text,primary key (posid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建postable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreatePos = true;
        }
        
        static bool bCreateVersion = false;
        if (!bCreateVersion) {
            sql = [NSString stringWithFormat:@"create table if not exists versiontable(versionid text)"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建versiontable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateVersion = true;
        }

        static bool bCreateProduct = false;
        if (!bCreateProduct) {
            sql = [NSString stringWithFormat:@"create table if not exists producttable(bulbid text,bulbtype text,bulbparam text,bulbimage text,versionid text,primary key (bulbid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建producttable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateProduct = true;
        }
        
        static bool bCreateType = false;
        if (!bCreateType) {
            
            sql = [NSString stringWithFormat:@"create table if not exists typetable(typeid text,posid text,proid text,versionid text,primary key (typeid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建typetable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateType = true;
        }
        
        return database;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }
    
}


+(BOOL) addRoomTableObj:(RoomTableObj*) roomobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into roomtable values('%@','%@','%@');",roomobj.m_roomId,roomobj.m_roomName,roomobj.m_hallId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addRoomTableObj :roomtable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

+(BOOL) deleteRoomTableObj:(RoomTableObj*) roomobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from roomtable where roomid='%@';",roomobj.m_roomId];

        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 roomtable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 roomtable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}


+(BOOL) alterRoomTableObj:(RoomTableObj*) roomobj{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into roomtable values('%@','%@','%@');",roomobj.m_roomId,roomobj.m_roomName,roomobj.m_hallId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addRoomTableObj :roomtable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }
}
//
////获取所有信息
//+(NSArray*) getAllRoomTableObj
//{
//    sqlite3* database = nil;
//    @try {
//        //打开数据库
//        database  = [DataBase createDB];;
//        NSString* sql = @"select * from roomtable;";
//        
//        //  @"select db_recordbusnum from recordbusnum";
//        sqlite3_stmt *statement;
//        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
//            
//            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
//            while (sqlite3_step(statement) == SQLITE_ROW) {
//                char* data0 = (char*)sqlite3_column_text(statement, 0);
//                char* data1 = (char*)sqlite3_column_text(statement, 1);
//                char* data2 = (char*)sqlite3_column_text(statement, 2);
//                char* data3 = (char*)sqlite3_column_text(statement, 3);
//                char* data4 = (char*)sqlite3_column_text(statement, 4);
//                
//                RoomTableObj* line = [[RoomTableObj alloc] init];
//                
//                line.m_roomId = [[NSString alloc] initWithUTF8String:data0];
//                line.m_hallImage = [[NSString alloc] initWithUTF8String:data1];
//                line.m_description = [[NSString alloc] initWithUTF8String:data2];
//                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
//                line.m_orderId = [[NSString alloc] initWithUTF8String:data4];
//
//                [dataArry addObject:line];
//                [line release];
//                
//            }
//            sqlite3_finalize(statement);
//            sqlite3_close(database);
//            [dataArry autorelease];		
//            return dataArry;
//        }
//        sqlite3_close(database);
//        NSLog(@"getAllRoomTableObj 查询roomtable表时失败！");
//        return nil;
//    }
//    @catch (NSException *exception) {
//        sqlite3_close(database);
//        return nil;
//    }
//
//}
//获取某个 房间的 信息
+(RoomTableObj*) getOneRoomTableInfo:(NSString*) roomid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = [NSString stringWithFormat:@"select * from roomtable where roomid='%@';",roomid];
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            RoomTableObj* line = [[[RoomTableObj alloc] init] autorelease];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                
                line.m_roomId = [[NSString alloc] initWithUTF8String:data0];
                line.m_roomName = [[NSString alloc] initWithUTF8String:data1];
                line.m_hallId = [[NSString alloc] initWithUTF8String:data2];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);	
            return line;

        }
        sqlite3_close(database);
        NSLog(@"getOneRoomTableInfo:(NSString*) roomid 查询roomtable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}


+(BOOL) addImageTableObj:(ImageTableObj*)imageobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* des = [imageobj.m_description stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
        
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into imagetable values('%@','%@','%@','%@','%@');",imageobj.m_imageId,imageobj.m_imageUrl,imageobj.m_roomId,des,imageobj.m_bulbVersionId];
        
        NSLog(@" upusql = %@",updateSql);
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addImageTableObj :roomtable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteImageTableObj:(ImageTableObj*) imageobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from imagetable where imageid='%@';",imageobj.m_imageId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 imageid 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 imageid 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterImageTableObj:(ImageTableObj*) imageobj
{

    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* des = [imageobj.m_description stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
        
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into imagetable values('%@','%@','%@','%@','%@');",imageobj.m_imageId,imageobj.m_imageUrl,imageobj.m_roomId,des,imageobj.m_bulbVersionId];
        
        NSLog(@" upusql = %@",updateSql);
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"alterImageTableObj :imagetable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllImageTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from imagetable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                ImageTableObj* line = [[ImageTableObj alloc] init];
                
                line.m_imageId = [[NSString alloc] initWithUTF8String:data0];
                line.m_imageUrl = [[NSString alloc] initWithUTF8String:data1];
                line.m_roomId = [[NSString alloc] initWithUTF8String:data2];
                line.m_description = [[NSString alloc] initWithUTF8String:data3];
                line.m_bulbVersionId = [[NSString alloc] initWithUTF8String:data4];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询getAllImageTableObj imagetable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 图片的 信息
+(NSArray*) getImageTableInfoRoomid:(NSString*) roomid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = [NSString stringWithFormat:@"select * from imagetable where roomid='%@';",roomid];

        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                ImageTableObj* line = [[ImageTableObj alloc] init];
                
                line.m_imageId = [[NSString alloc] initWithUTF8String:data0];
                line.m_imageUrl = [[NSString alloc] initWithUTF8String:data1];
                line.m_roomId = [[NSString alloc] initWithUTF8String:data2];
                line.m_description = [[NSString alloc] initWithUTF8String:data3];
                line.m_bulbVersionId = [[NSString alloc] initWithUTF8String:data4];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询ggetOneImageTableInfoRoomid:(NSString*) roomid imagetable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 图片的 信息
+(ImageTableObj*) getOneImageTableInfoImageid:(NSString*) imageid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from imagetable where imageid='%@';",imageid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            ImageTableObj* line = [[[ImageTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                
                line.m_imageId = [[NSString alloc] initWithUTF8String:data0];
                line.m_imageUrl = [[NSString alloc] initWithUTF8String:data1];
                line.m_roomId = [[NSString alloc] initWithUTF8String:data2];
                line.m_description = [[NSString alloc] initWithUTF8String:data3];
                line.m_bulbVersionId = [[NSString alloc] initWithUTF8String:data4];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"getOneImageTableInfoImageid:(NSString*) imageid  查询imagetable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}


+(BOOL) addProductTableObj:(ProductTableObj*) productobj{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into producttable values('%@','%@','%@','%@','%@');",productobj.m_bulbId,productobj.m_bulbType,productobj.m_bulbParam,productobj.m_bulbImage,productobj.m_bulbVersionId];
        
       // producttable(bulbid text,bulbname text,bulbtype text,bulbparam text,bulbimage text,versionid text,primary key (bulbid))
        
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"更新producttable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteProductTableObj:(ProductTableObj*) productobj{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from producttable where bulbid='%@';",productobj.m_bulbId];

        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 producttable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 producttable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterProductTableObj:(ProductTableObj*) productobj{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into producttable values('%@','%@','%@','%@','%@');",productobj.m_bulbId,productobj.m_bulbType,productobj.m_bulbParam,productobj.m_bulbImage,productobj.m_bulbVersionId];
        
        // producttable(bulbid text,bulbname text,bulbtype text,bulbparam text,bulbimage text,versionid text,primary key (bulbid))
        
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"更新producttable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllBulbTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
       database  = [DataBase createDB];;
        NSString* sql = @"select * from producttable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                ProductTableObj* line = [[ProductTableObj alloc] init];

                line.m_bulbId = [[NSString alloc] initWithUTF8String:data0];
                line.m_bulbType = [[NSString alloc] initWithUTF8String:data1];
                line.m_bulbParam = [[NSString alloc] initWithUTF8String:data2];
                line.m_bulbImage = [[NSString alloc] initWithUTF8String:data3];
                line.m_bulbVersionId = [[NSString alloc] initWithUTF8String:data4];
 
                [dataArry addObject:line];
                [line release];

            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询producttable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

//获取 同类型 产品 信息
+(NSArray*) getBulbTableObjByProtype:(NSString*) protype
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = [NSString stringWithFormat:@"select * from producttable where bulbtype='%@';",protype];
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                ProductTableObj* line = [[ProductTableObj alloc] init];
                
                line.m_bulbId = [[NSString alloc] initWithUTF8String:data0];
                line.m_bulbType = [[NSString alloc] initWithUTF8String:data1];
                line.m_bulbParam = [[NSString alloc] initWithUTF8String:data2];
                line.m_bulbImage = [[NSString alloc] initWithUTF8String:data3];
                line.m_bulbVersionId = [[NSString alloc] initWithUTF8String:data4];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询producttable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

//获取某个 灯泡的 信息
+(ProductTableObj*) getOneBulbTableInfo:(NSString*) bulbid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from producttable where bulbid='%@';",bulbid];
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            ProductTableObj* line = [[[ProductTableObj alloc] init] autorelease];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                
                line.m_bulbId = [[NSString alloc] initWithUTF8String:data0];
                line.m_bulbType = [[NSString alloc] initWithUTF8String:data1];
                line.m_bulbParam = [[NSString alloc] initWithUTF8String:data2];
                line.m_bulbImage = [[NSString alloc] initWithUTF8String:data3];
                line.m_bulbVersionId = [[NSString alloc] initWithUTF8String:data4];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
        }
        sqlite3_close(database);
        NSLog(@"查询producttable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }
}

+(BOOL) addPosTableObj:(PosTableObj*) posobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into postable values('%@','%@','%@','%@','%@','%@');",posobj.m_posId,posobj.m_posX,posobj.m_posY,posobj.m_bulbId,posobj.m_imageId,posobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"add postable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;

    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deletePosTableObj:(PosTableObj*) posobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from postable where posid='%@';",posobj.m_posId];

        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 postable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 postable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterPosTableObj:(PosTableObj*) posobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into postable values('%@','%@','%@','%@','%@','%@');",posobj.m_posId,posobj.m_posX,posobj.m_posY,posobj.m_bulbId,posobj.m_imageId,posobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"alter postable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllPosTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from postable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                char* data5 = (char*)sqlite3_column_text(statement, 5);
                
                PosTableObj* line = [[PosTableObj alloc] init];
                
                line.m_posId = [[NSString alloc] initWithUTF8String:data0];
                line.m_posX = [[NSString alloc] initWithUTF8String:data1];
                line.m_posY = [[NSString alloc] initWithUTF8String:data2];
                line.m_bulbId = [[NSString alloc] initWithUTF8String:data3];
                line.m_imageId = [[NSString alloc] initWithUTF8String:data4];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data5];
 
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"getAllPosTableObj postable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

//获取某个 房间的 某个图片的 所有信息
+(NSArray*) getPosTableInfoImgeId:(NSString*) imageid
{    
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from postable where imageid='%@';",imageid];
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                char* data5 = (char*)sqlite3_column_text(statement, 5);
                
                PosTableObj* line = [[PosTableObj alloc] init];
                
                line.m_posId = [[NSString alloc] initWithUTF8String:data0];
                line.m_posX = [[NSString alloc] initWithUTF8String:data1];
                line.m_posY = [[NSString alloc] initWithUTF8String:data2];
                line.m_bulbId = [[NSString alloc] initWithUTF8String:data3];
                line.m_imageId = [[NSString alloc] initWithUTF8String:data4];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data5];

                
                [dataArry addObject:line];
                [line release];

            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"+(NSArray*) getOnePosTableInfoImgeId:(NSString*) imageid 11  postable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }
    
}


//获取某个 灯泡的 信息
+(PosTableObj*) getOnePosTableInfoPosId:(NSString*) posid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from postable where posid='%@';",posid];
                //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            PosTableObj* line = [[[PosTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                char* data5 = (char*)sqlite3_column_text(statement, 5);

                line.m_posId = [[NSString alloc] initWithUTF8String:data0];
                line.m_posX = [[NSString alloc] initWithUTF8String:data1];
                line.m_posY = [[NSString alloc] initWithUTF8String:data2];
                line.m_bulbId = [[NSString alloc] initWithUTF8String:data3];
                line.m_imageId = [[NSString alloc] initWithUTF8String:data4];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data5];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"+(PosTableObj*) getOnePosTableInfoPosId:(NSString*) posid 查询postable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

//-------------------------类型 表------------------------------
+(BOOL) addTypeTableObj:(TypeTableObj*) posobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into typetable values('%@','%@','%@','%@');",posobj.m_typeId,posobj.m_posId,posobj.m_bulbId,posobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"add typetable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }
}


+(BOOL) deleteTypeTableObj:(TypeTableObj*) posobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from typetable where typeid='%@';",posobj.m_typeId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 typetable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 typetable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

    
  //  sql = [NSString stringWithFormat:@"create table if not exists typetable(typeid text,posid text,proid text,versionid text,primary key (typeid))"];
    

}
+(BOOL) alterTypeTableObj:(TypeTableObj*) posobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into typetable values('%@','%@','%@','%@');",posobj.m_typeId,posobj.m_posId,posobj.m_bulbId,posobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"alterTypeTableObj typetable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllTypeTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from typetable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                
                TypeTableObj* line = [[TypeTableObj alloc] init];
                
                line.m_typeId = [[NSString alloc] initWithUTF8String:data0];
                line.m_posId = [[NSString alloc] initWithUTF8String:data1];
                line.m_bulbId = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"getAllTypeTableObj typetable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取 展厅所有 图片
+(NSArray*) getTypeTableInfoPosId:(NSString*) posid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from typetable where posid='%@';",posid];
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                
                TypeTableObj* line = [[TypeTableObj alloc] init];
                
                line.m_typeId = [[NSString alloc] initWithUTF8String:data0];
                line.m_posId = [[NSString alloc] initWithUTF8String:data1];
                line.m_bulbId = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                [dataArry addObject:line];
                [line release];

                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"+(NSArray*) getTypeTableInfoPosId:(NSString*) posid  typetable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

//获取某个 灯泡的 信息
+(TypeTableObj*) getOnePosTableInfoTypeId:(NSString*) type
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from typetable where typeid='%@';",type];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            TypeTableObj* line = [[[TypeTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                
                line.m_typeId = [[NSString alloc] initWithUTF8String:data0];
                line.m_posId = [[NSString alloc] initWithUTF8String:data1];
                line.m_bulbId = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"+(TypeTableObj*) getOnePosTableInfoTypeId:(NSString*) type 查询typetable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}



+(BOOL) addVersionTableObj:(NSString*) version
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        
        bool suc1 = [DataBase deleteVersionTableObj];
        if (!suc1) {
            return NO;
        }
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into versiontable values('%@');",version];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"add versiontable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}


+(BOOL) deleteVersionTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = @"delete from versiontable;";
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 versiontable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 versiontable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}


+(NSString*) getAllVersionTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from versiontable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSString* restr = nil;
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);

                restr = [[[NSString alloc] initWithUTF8String:data0] autorelease];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return restr;
        }
        sqlite3_close(database);
        NSLog(@"getAllVersionTableObj versiontable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

@end

//
//  DataBase.h
//  LiDaXin-iPad
//
//  Created by zheng wanxiang on 12-9-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DataProcess.h"
#import "RoomTableObj.h"
#import "ProductTableObj.h"
#import "PosTableObj.h"
#import "ImageTableObj.h"
#import "TypeTableObj.h"


@interface DataBase : NSObject

+(RoomTableObj*) GetSingleRoomTableObj;
//创建数据库
+(sqlite3*) createDB;
//-------------------------房间------------------------------
+(BOOL) addRoomTableObj:(RoomTableObj*) roomobj;
+(BOOL) deleteRoomTableObj:(RoomTableObj*) roomobj;
+(BOOL) alterRoomTableObj:(RoomTableObj*) roomobj;
//获取所有信息
//+(NSArray*) getAllRoomTableObj;
//获取某个 房间的 所有信息
+(RoomTableObj*) getOneRoomTableInfo:(NSString*) roomid;

//-------------------------房间图片------------------------------
+(BOOL) addImageTableObj:(ImageTableObj*)imageobj;
+(BOOL) deleteImageTableObj:(ImageTableObj*) imageobj;
+(BOOL) alterImageTableObj:(ImageTableObj*) imageobj;

//获取所有信息
+(NSArray*) getAllImageTableObj;
//获取某 图片的 信息
+(NSArray*) getImageTableInfoRoomid:(NSString*) roomid;
//获取某 图片的 信息
+(ImageTableObj*) getOneImageTableInfoImageid:(NSString*) imageid;

//-------------------------产品表------------------------------
+(BOOL) addProductTableObj:(ProductTableObj*) productobj;
+(BOOL) deleteProductTableObj:(ProductTableObj*) productobj;
+(BOOL) alterProductTableObj:(ProductTableObj*) productobj;

//获取所有信息
+(NSArray*) getAllBulbTableObj;

//获取 同类型 产品 信息
+(NSArray*) getBulbTableObjByProtype:(NSString*) protype;
//获取某个 灯泡的 信息
+(ProductTableObj*) getOneBulbTableInfo:(NSString*) bulbid;

//-------------------------坐标表------------------------------
+(BOOL) addPosTableObj:(PosTableObj*) posobj;
+(BOOL) deletePosTableObj:(PosTableObj*) posobj;
+(BOOL) alterPosTableObj:(PosTableObj*) posobj;

//获取所有信息
+(NSArray*) getAllPosTableObj;
//获取 展厅所有 图片
+(NSArray*) getPosTableInfoImgeId:(NSString*) imageid;

//获取某个 灯泡的 信息
+(PosTableObj*) getOnePosTableInfoPosId:(NSString*) posid;

//-------------------------类型 表------------------------------
+(BOOL) addTypeTableObj:(TypeTableObj*) posobj;
+(BOOL) deleteTypeTableObj:(TypeTableObj*) posobj;
+(BOOL) alterTypeTableObj:(TypeTableObj*) posobj;

//获取所有信息
+(NSArray*) getAllTypeTableObj;
//获取 展厅所有 图片
+(NSArray*) getTypeTableInfoPosId:(NSString*) posid;

//获取某个 灯泡的 信息
+(TypeTableObj*) getOnePosTableInfoTypeId:(NSString*) type;

//-------------------------总版本表------------------------------
+(BOOL) addVersionTableObj:(NSString*) version;
+(BOOL) deleteVersionTableObj;

+(NSString*) getAllVersionTableObj;

@end

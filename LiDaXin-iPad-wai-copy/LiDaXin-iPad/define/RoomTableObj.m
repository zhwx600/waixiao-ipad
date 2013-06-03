//
//  RoomTableObj.m
//  LiDaXin-iPad
//
//  Created by apple on 12-9-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomTableObj.h"

@implementation RoomTableObj

@synthesize m_roomId,m_hallId,m_roomName,m_imageTableObjArr;

-(id) init
{
    if (self = [super init]) {
        self.m_roomId = nil;
        self.m_roomName = nil;
        self.m_hallId = nil;
        self.m_imageTableObjArr = nil;
    }
    return self;
}

-(void) setRoomNameByRoomId:(NSString*) roomid
{
    
    NSString* str = [roomid substringFromIndex:1];
    
    switch (str.intValue-1) {
        case 0:
        {
            self.m_roomName = @"卧室";
        }
            break;
        case 1:
        {
            self.m_roomName = @"洗手间";
        }
            break;
        case 2:
        {
            self.m_roomName = @"儿童房";
        }
            break;
        case 3:
        {
            self.m_roomName = @"书房";
        }
            break;
        case 4:
        {
            self.m_roomName = @"厨房";
        }
            break;
        case 5:
        {
            self.m_roomName = @"餐厅";
        }
            break;
        case 6:
        {
            self.m_roomName = @"客厅";
        }
            break;
        case 7:
        {
            self.m_roomName = @"走道";
        }
            break;
        case 8:
        {
            self.m_roomName = @"阳台";
        }
            break;
        default:
            break;
    }
    
    self.m_roomId = roomid;
    
}

-(void) dealloc
{

    [m_roomId release];
    [m_hallId release];
    [m_roomName release];
    [m_imageTableObjArr release];
    [super dealloc];
}

@end

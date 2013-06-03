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
    
    if (0 == [roomid compare:@"A1"])
        self.m_roomName = @"Bedroom";
    else if(0 == [roomid compare:@"A2"])
        self.m_roomName = @"Study Room";
    else if(0 == [roomid compare:@"A3"])
        self.m_roomName = @"Kitchen";
    else if(0 == [roomid compare:@"A4"])
        self.m_roomName = @"Children's Room";
    else if(0 == [roomid compare:@"A5"])
        self.m_roomName = @"Toilet";
    else if(0 == [roomid compare:@"A6"])
        self.m_roomName = @"Living Room";
    else if(0 == [roomid compare:@"A7"])
        self.m_roomName = @"Dining Room";
    else if(0 == [roomid compare:@"A8"])
        self.m_roomName = @"Product Demo";
    else if(0 == [roomid compare:@"A9"])
        self.m_roomName = @"Culture Wall";
    
    else if(0 == [roomid compare:@"B1"])
        self.m_roomName = @"Lighting Experience Area";
    else if(0 == [roomid compare:@"B2"])
        self.m_roomName = @"Product Area";
    else if(0 == [roomid compare:@"B3"])
        self.m_roomName = @"Bar";
    else if(0 == [roomid compare:@"B4"])
        self.m_roomName = @"Image/product Area";
    else if(0 == [roomid compare:@"B5"])
        self.m_roomName = @"Smart Lighting Area";
    else if(0 == [roomid compare:@"B6"])
        self.m_roomName = @"Promotion Area";
    else if(0 == [roomid compare:@"B7"])
        self.m_roomName = @"Meeting Area";
    else if(0 == [roomid compare:@"B8"])
        self.m_roomName = @"Product Area";
    else if(0 == [roomid compare:@"B9"])
        self.m_roomName = @"Lighting Experience Area";
    else if(0 == [roomid compare:@"B10"])
        self.m_roomName = @"Promotion Area";
    else if(0 == [roomid compare:@"B11"])
        self.m_roomName = @"Product Area";
    else if(0 == [roomid compare:@"B12"])
        self.m_roomName = @"Promotion Area";
    
    else if(0 == [roomid compare:@"C1"])
        self.m_roomName = @"Product Area";
    else if(0 == [roomid compare:@"C2"])
        self.m_roomName = @"Product Area";
    else if(0 == [roomid compare:@"C3"])
        self.m_roomName = @"Office";
    else if(0 == [roomid compare:@"C4"])
        self.m_roomName = @"Product Area";
    else if(0 == [roomid compare:@"C5"])
        self.m_roomName = @"Showcase";
    else if(0 == [roomid compare:@"C6"])
        self.m_roomName = @"Corridor";
    else if(0 == [roomid compare:@"C7"])
        self.m_roomName = @"Hall";
    else if(0 == [roomid compare:@"C8"])
        self.m_roomName = @"Bar";
    else if(0 == [roomid compare:@"C9"])
        self.m_roomName = @"Commercial Area";
    else if(0 == [roomid compare:@"C10"])
        self.m_roomName = @"Showcase";
    

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

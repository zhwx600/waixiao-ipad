//
//  TypeTableObj.m
//  LiDaXin-iPad
//
//  Created by apple on 12-11-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TypeTableObj.h"

@implementation TypeTableObj
@synthesize m_flag,m_posId,m_bulbId,m_typeId,m_versionId;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;

        self.m_posId = nil;
        self.m_bulbId = nil;
        self.m_typeId = nil;
        self.m_flag = 2;
    }
    return self;
}

-(void) dealloc
{
    [m_versionId release];
    [m_posId release];
    [m_bulbId release];
    [m_typeId release];
    [super dealloc];
}


@end

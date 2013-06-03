//
//  TypeTableObj.h
//  LiDaXin-iPad
//
//  Created by apple on 12-11-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeTableObj : NSObject

@property (nonatomic,retain) NSString* m_typeId;
@property (nonatomic,retain) NSString* m_posId;
@property (nonatomic,retain) NSString* m_bulbId;
@property (nonatomic,retain) NSString* m_versionId;
@property (nonatomic)int m_flag;//下在数据时 标记操作 类型 -1 删除，0修改，1添加

@end

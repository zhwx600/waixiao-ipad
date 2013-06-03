//
//  ViewController.h
//  LiDaXin-iPad
//
//  Created by apple on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AZGenieView.h"
#import "RoomTableObj.h"
#import "DataBase.h"
#import "IDispatcher.h"
#import "HttpProcessor.h"
#import "xmlparser.h"
#import "iCarousel.h"

@interface ViewController : UIViewController<iCarouselDataSource,iCarouselDelegate,AZGenieAnimationDelegate,UIAlertViewDelegate>
{
	int  currenttag;
    
    bool m_bVersionDownFlag,m_bImageDownFlag,m_bPosDownFlag,m_bProductDownFlag,m_bTypeDownFlag;//是否 解析完 xml数据
    
    bool m_bVersionWriteDataBaseFlag,m_bImageWriteDataBaseFlag,m_bPosWriteDataBaseFlag,m_bProductWriteDataBaseFlag,m_bTypeWriteDataBaseFlag;
    
    bool m_bCancleDown;//取消下载按钮
    
    bool m_bHaveError;//整个升级过成功中 是否 有 异常 错误。
    
}

@property (retain, nonatomic) IBOutlet UIView *m_infoView;

@property (retain, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic,assign) BOOL wrap;

@property (strong, nonatomic) IBOutlet AZGenieView *genieView;
@property (retain, nonatomic) IBOutlet UIButton *m_infoButton;
@property (retain, nonatomic) IBOutlet UIImageView *m_tishiImageView;

@property (assign, nonatomic) bool isShow;
@property (nonatomic,retain) UIAlertView* m_shengjiAlertView;
//数据库 表 升级 相关变量

@property (retain)NSString* m_downVersionStr;
@property (retain)NSMutableArray* m_downImageArr;
@property (retain)NSMutableArray* m_downPosArr;
@property (retain)NSMutableArray* m_downProductArr;

@property (retain)NSMutableArray* m_downTypeArr;

-(void)Clickup:(NSInteger)tag;
-(NSInteger)getblank:(NSInteger)tag;
-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num;


-(void) initGenieView;

- (UIImage *)screenshotForViewController;
-(CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag;


- (IBAction)infoButton:(id)sender;
- (IBAction)shengjiButton:(id)sender;

- (IBAction)hallOneButton:(id)sender;
- (IBAction)hallTwoButton:(id)sender;
- (IBAction)hallThreeButton:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *colseInforView;
- (IBAction)closeInfoView:(id)sender;



//显示还是 隐藏提示View
-(void) hideOrShowTishiImageView:(NSString*) str;

-(void) initRoomTableData;

//升级请求
-(void) requestImageTable;
-(void) receiveDataByImageTable:(NSData*) data;

//升级请求
-(void) requestPosTable;
-(void) receiveDataByPosTable:(NSData*) data;

//升级请求
-(void) requestProductTable;
-(void) receiveDataByProductTable:(NSData*) data;

//升级请求
-(void) requestTypeTable;
-(void) receiveDataByTypeTable:(NSData*) data;

//升级请求
-(void) requestVersionTable;
-(void) receiveDataByVersionTable:(NSData*) data;

//开启一个 单独线程 下载图片和 写数据库
-(void) startDownImageAndWriteToDatabase;
-(void) threadDownWriteFun;

-(void) callUpgradeSuccOnMainThread;
-(void) callUpgradeFailureOnMainThread;
-(void) callUpgradeNoNetOnMainThread;

@end

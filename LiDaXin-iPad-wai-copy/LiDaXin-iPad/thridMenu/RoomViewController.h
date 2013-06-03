//
//  RoomViewController.h
//  LiDaXin-iPad
//
//  Created by apple on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BulbDetailParam.h"
#import "xmlparser.h"
#import "xmlCommand.h"
#import "RoomInformation.h"
#import "BulbDetailParam.h"
#import "IDispatcher.h"
#import "HttpProcessor.h"

#import "DataBase.h"
#import "RoomTableObj.h"
#import "ProductTableObj.h"
#import "PosTableObj.h"

@interface RoomViewController : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate>
{
        double m_lastTimeDouble;
}
@property (retain, nonatomic) IBOutlet UIView *m_mainView;
@property (retain, nonatomic) IBOutlet UIView *m_detailView;
@property (retain, nonatomic) IBOutlet UIView *m_shadeView;
@property (retain, nonatomic) IBOutlet UIScrollView *m_imageScrollView;

@property (retain, nonatomic) IBOutlet UILabel *m_bulbParam1;
@property (retain, nonatomic) IBOutlet UILabel *m_bulbParam2;
@property (retain, nonatomic) IBOutlet UILabel *m_bulbParam3;
@property (retain, nonatomic) IBOutlet UILabel *m_bulbParam4;
@property (retain, nonatomic) IBOutlet UILabel *m_bulbParam5;
@property (retain, nonatomic) IBOutlet UILabel *m_bulbParam6;
@property (retain, nonatomic) IBOutlet UILabel *m_bulbParam7;
@property (retain, nonatomic) IBOutlet UILabel *m_bulbParam8;
@property (retain, nonatomic) IBOutlet UILabel *m_bulbParam9;
@property (retain, nonatomic) IBOutlet UIScrollView *m_roomImageScrollView;
@property (retain, nonatomic) IBOutlet UIButton *m_pullButton;
@property (retain, nonatomic) IBOutlet UIView *m_roomLeftView;
@property (retain, nonatomic) IBOutlet UIScrollView *m_mainRoomScrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *m_pageControl;
@property (retain, nonatomic) IBOutlet UIView *m_page1View;
@property (retain, nonatomic) IBOutlet UINavigationItem *m_navItem;
@property (retain, nonatomic) IBOutlet UIImageView *m_selectBulbImageView;
@property (retain, nonatomic) IBOutlet UIView *m_imageInfoView;
@property (retain, nonatomic) IBOutlet UILabel *m_imageInfoLabel;


@property (nonatomic)bool m_pageControllUsed;
@property (nonatomic)int m_imageCount;
@property (nonatomic,retain)NSMutableArray *m_viewArr;

@property (nonatomic,retain) HttpProcessor* m_http;
@property (nonatomic,retain) NSMutableArray* m_otherBulbArr;

//取数据库  数据相关

@property (nonatomic,retain) NSMutableArray* m_rRoomProObjArr;//产品 数组



- (IBAction)pullButton:(id)sender;

- (IBAction)lampOneButton:(id)sender;
- (IBAction)close:(id)sender;
- (IBAction)closeModelView:(id)sender;
- (IBAction)changePge:(id)sender;

-(void) initScrollView;
-(void) imageSelectButton:(id)sender;

- (IBAction)imageInfoButtonAction:(id)sender;
- (IBAction)closeImageInfoView:(id)sender;

-(void) loadOtherRoomImageInfo:(NSString*) roomid Flag:(int) flag;
-(void) handleSwipeFrom:(UISwipeGestureRecognizer*) recognizer;


-(void) parserBlubStr;

-(void) requestHttp;

-(void) initPosTable;
-(void) initRoomTable;
-(void) initProductTable;

-(void) getPrintPosTable;
-(void) getPrintRoomTable;
-(void) getPrintProductTable;

-(void) initImageView;
-(void) initPageScrollView;

-(void) initProductScrollView;
-(void) initAllImageAndPosData;

-(void) downFileTest;

@end

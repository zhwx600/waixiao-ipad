//
//  AppDelegate.h
//  LiDaXin-iPad
//
//  Created by apple on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HallOneViewController;
@class HallTwoViewController;
@class HallThreeViewController;
@class ViewController;
//-----------

@class RoomViewController;//卧室
@class DetailParamViewController;
@class OtherOptionViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic,retain)HallOneViewController* m_hallOne;
@property (nonatomic,retain)HallTwoViewController* m_hallTwo;
@property (nonatomic,retain)HallThreeViewController* m_hallThree;
//--------------------------

@property (nonatomic,retain)RoomViewController* m_bedRoomViewController;

@property (nonatomic,retain)DetailParamViewController* m_detailView;
@property(nonatomic,retain)OtherOptionViewController* m_otherView;



-(void) entryHallOne;
-(void) entryHallTwo;
-(void) entryHallThree;

-(void) entryBedRoom;

-(void) entryDetail;

-(void) entryOther;

@end

//
//  HallThreeViewController.h
//  LiDaXin-iPad
//
//  Created by apple on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DataBase.h"
#import "RoomTableObj.h"
#import <QuartzCore/QuartzCore.h>
#import "AZGenieView.h"


@interface HallThreeViewController : UIViewController<AZGenieAnimationDelegate>
- (IBAction)close:(id)sender;
- (IBAction)roomButton:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *m_shadeView;
@property (retain, nonatomic) IBOutlet UIView *m_blockImage1;
@property (retain, nonatomic) IBOutlet UIView *m_blockImage2;
@property (retain, nonatomic) IBOutlet UIView *m_blockImage3;
@property (retain, nonatomic) IBOutlet UIView *m_blockImage4;
@property (retain, nonatomic) IBOutlet UIView *m_blockImage5;
@property (retain, nonatomic) IBOutlet UIView *m_blockImage6;
@property (retain, nonatomic) IBOutlet UIView *m_blockImage7;
@property (retain, nonatomic) IBOutlet UIView *m_blockImage8;
@property (retain, nonatomic) IBOutlet UIView *m_blockImage9;
@property (retain, nonatomic) IBOutlet UIView *m_blockImage10;


@property (nonatomic)bool m_bFreshImageBlock;

//-----------
@property (assign, nonatomic) bool isShow;
@property (retain, nonatomic) IBOutlet UIView *m_infoView;
@property (retain, nonatomic) IBOutlet AZGenieView *genieView;
@property (retain, nonatomic) IBOutlet UIButton *m_infoButton;
//------------
- (IBAction)closeInfoView:(id)sender;
- (IBAction)infoButton:(id)sender;

-(void) initGenieView;
- (UIImage *)screenshotForViewController;
-(CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag;

@end

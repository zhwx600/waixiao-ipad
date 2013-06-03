//
//  HallOneViewController.m
//  LiDaXin-iPad
//
//  Created by apple on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HallOneViewController.h"
#import "AppDelegate.h"
#import "xmlCommand.h"
#import "xmlparser.h"
#include <string>

#import "HallInformation.h"


@interface HallOneViewController ()

@end

@implementation HallOneViewController
@synthesize m_infoView;
@synthesize genieView;
@synthesize m_infoButton;
@synthesize m_shadeView;
@synthesize m_blockImage1;
@synthesize m_blockImage2;
@synthesize m_blockImage3;
@synthesize m_blockImage4;
@synthesize m_blockImage5;
@synthesize m_blockImage6;
@synthesize m_blockImage7;
@synthesize m_blockImage8;
@synthesize m_blockImage9;
@synthesize isShow;
@synthesize m_bFreshImageBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"展厅一";
    self.m_bFreshImageBlock = YES;
   // [self parserStr];
    
  //  [NSThread detachNewThreadSelector:@selector(initGenieView) toTarget:self withObject:nil];
    
   // [self initGenieView];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.m_bFreshImageBlock) {
        
        for (int i=0; i<9; i++) {
            NSString* str = [NSString stringWithFormat:@"A%d",i+1];
            NSArray* arr = [DataBase getImageTableInfoRoomid:str];
            if (arr && arr.count>0) {
                switch (i) {
                    case 0:
                    {
                        [self.m_blockImage1 setHidden:YES];
                    }
                        break;
                    case 1:
                    {
                        [self.m_blockImage2 setHidden:YES];
                    }
                        break;
                    case 2:
                    {
                        [self.m_blockImage3 setHidden:YES];
                    }
                        break;
                    case 3:
                    {
                        [self.m_blockImage4 setHidden:YES];
                    }
                        break;
                    case 4:
                    {
                        [self.m_blockImage5 setHidden:YES];
                    }
                        break;
                    case 5:
                    {
                        [self.m_blockImage6 setHidden:YES];
                    }
                        break;
                    case 6:
                    {
                        [self.m_blockImage7 setHidden:YES];
                    }
                        break;
                    case 7:
                    {
                        [self.m_blockImage8 setHidden:YES];
                    }
                        break;
                    case 8:
                    {
                        [self.m_blockImage9 setHidden:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
                
                
                
            }
            
            
            
        }
        
        
        
        
    }
    self.m_bFreshImageBlock = NO;
}


- (void)viewDidUnload
{
    [self setM_infoView:nil];
    [self setGenieView:nil];
    [self setM_infoButton:nil];
    [self setM_shadeView:nil];
    [self setM_blockImage1:nil];
    [self setM_blockImage2:nil];
    [self setM_blockImage3:nil];
    [self setM_blockImage4:nil];
    [self setM_blockImage5:nil];
    [self setM_blockImage6:nil];
    [self setM_blockImage7:nil];
    [self setM_blockImage8:nil];
    [self setM_blockImage9:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    
    return NO;
}

-(void) parserStr
{

    NSString* filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"hallInfo.xml"];

    NSData* aa = [NSData dataWithContentsOfFile:filePath];
    if ([DataProcess writeData:aa FileName:@"hallInfo.xml"]) {
        
    }
    
    filePath = [[DataProcess getMainPath] stringByAppendingPathComponent:@"hallInfo.xml"];
    NSError* error=nil;
    NSString* str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    
   // NSString* str = [NSString stringWithString:XMLSTR];
     NSLog(@"file content : %@",str);
    S_Data temdata;
    xmlparser::Decode([str UTF8String], &temdata);
    
    HallInformation* hallInfo = [[HallInformation alloc] init];
    
    [hallInfo initArrWithData:&temdata];
    
    NSLog(@" count = %d",hallInfo.m_roomInforArr.count);
    [hallInfo release];
    
    
}


- (IBAction)bedRoomButton:(id)sender 
{
    RoomTableObj* roomobj = [DataBase GetSingleRoomTableObj];
    
    if (roomobj.m_roomId) {
        NSLog(@"dd  roomid = %@ ===================",roomobj.m_roomId);
    }
    
    UIButton* button = (UIButton*) sender;
    switch (button.tag) {
        case 0:
        {
            roomobj.m_roomId = @"A1";
            roomobj.m_roomName = @"bedroom";
        }
            break;
        case 1:
        {
            roomobj.m_roomId = @"A2";
            roomobj.m_roomName = @"study room";
        }
            break;
        case 2:
        {
            roomobj.m_roomId = @"A3";
            roomobj.m_roomName = @"kitchen";
        }
            break;
        case 3:
        {
            roomobj.m_roomId = @"A4";
            roomobj.m_roomName = @"children's room";
        }
            break;
        case 4:
        {
            roomobj.m_roomId = @"A5";
            roomobj.m_roomName = @"toilet";
        }
            break;
        case 5:
        {
            roomobj.m_roomId = @"A6";
            roomobj.m_roomName = @"living room";
        }
            break;
        case 6:
        {
            roomobj.m_roomId = @"A7";
            roomobj.m_roomName = @"dining room";
        }
            break;
        case 7:
        {
            roomobj.m_roomId = @"A8";
            roomobj.m_roomName = @"product demo";
        }
            break;
        case 8:
        {
            roomobj.m_roomId = @"A9";
            roomobj.m_roomName = @"culture wall";
        }
            break;
        case 9:
        {
            roomobj.m_roomId = @"A10";
            roomobj.m_roomName = @"产品展示";
        }
            break;
        case 10:
        {
            roomobj.m_roomId = @"A11";
            roomobj.m_roomName = @"企业文化";
        }
            break;
                 
        default:
            break;
    }
    
    RoomTableObj* temobj = [DataBase GetSingleRoomTableObj];
    temobj.m_imageTableObjArr = [[NSMutableArray alloc] initWithArray:[DataBase getImageTableInfoRoomid:temobj.m_roomId]];

    if (!temobj.m_imageTableObjArr || temobj.m_imageTableObjArr.count <= 0) {
        NSString* str = [NSString stringWithFormat:@"No picture information in the room [%@].",temobj.m_roomName];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Warning message" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate entryBedRoom];
    
}

- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 
#pragma mark 简介显示 

- (UIImage *)screenshotForViewController
{
    //    UIGraphicsBeginImageContextWithOptions(self.m_infoView.bounds.size, YES, [[UIScreen mainScreen] scale]);
    //    [self.m_infoView.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    
    
    return [UIImage imageNamed:@"gongsi_info.png"];
}

- (void)geineAnimationDone
{
    [self.m_infoButton setEnabled:YES];
    if (self.isShow)
        self.m_infoView.hidden = NO;
}

-(void) initGenieView
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    self.isShow = NO;
    UIImage *screenshot = [self screenshotForViewController];
    [self.genieView setDelegate:self];
    self.genieView.renderImage = screenshot;
    self.genieView.m_realView = self.m_infoView;
    
    CGRect rect = self.m_infoButton.frame;
    
    rect.origin.x +=5;
    rect.origin.y +=3;
    rect.size.width -=20;
    rect.size.height =-20;
    
    [self.genieView setRenderFrame:self.m_infoView.frame andTargetFrame:rect];
    [self.view insertSubview:self.m_infoView atIndex:200];
    [pool release];
}

- (IBAction)closeInfoView:(id)sender 
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = self.m_infoView.frame;
        rect.origin.y = 748;
        
        [self.m_infoView setFrame:rect];
        self.m_shadeView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
    
    return;

    self.isShow = NO;
    self.m_infoView.hidden = YES;
    [self.genieView genieAnimationShow:self.isShow withDuration:1];
}

- (IBAction)infoButton:(id)sender 
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.m_infoView.center = self.view.center;
        self.m_shadeView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    return;
    
    if (!self.isShow){
        self.isShow = YES;
        //[NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(geineAnimationDone) userInfo:nil repeats:NO];
    }else {
        return;
    }
    
    [self.m_infoButton setEnabled:NO];
    [self.genieView genieAnimationShow:self.isShow withDuration:1];
}


- (void)dealloc {
    [m_infoView release];
    [genieView release];
    [m_infoButton release];
    [m_shadeView release];
    [m_blockImage1 release];
    [m_blockImage2 release];
    [m_blockImage3 release];
    [m_blockImage4 release];
    [m_blockImage5 release];
    [m_blockImage6 release];
    [m_blockImage7 release];
    [m_blockImage8 release];
    [m_blockImage9 release];
    [super dealloc];
}
@end

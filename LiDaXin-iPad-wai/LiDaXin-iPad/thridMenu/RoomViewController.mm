//
//  RoomViewController.m
//  LiDaXin-iPad
//
//  Created by apple on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import <QuartzCore/CALayer.h>

NSString* paramSeparetedStr = @"$paramSeparate$";

@interface RoomViewController ()

@end

@implementation RoomViewController
@synthesize m_mainView;
@synthesize m_detailView;
@synthesize m_shadeView;
@synthesize m_imageScrollView;
@synthesize m_bulbParam1;
@synthesize m_bulbParam2;
@synthesize m_bulbParam3;
@synthesize m_bulbParam4;
@synthesize m_bulbParam5;
@synthesize m_bulbParam6;
@synthesize m_bulbParam7;
@synthesize m_bulbParam8;
@synthesize m_bulbParam9;
@synthesize m_roomImageScrollView;
@synthesize m_pullButton;
@synthesize m_roomLeftView;
@synthesize m_mainRoomScrollView;
@synthesize m_pageControl;
@synthesize m_page1View;
@synthesize m_navItem;
@synthesize m_selectBulbImageView;
@synthesize m_imageInfoView;
@synthesize m_imageInfoLabel;
@synthesize m_paramScrollView;
@synthesize m_desTextView;
@synthesize m_otherBulbArr;
@synthesize m_http;
@synthesize m_imageCount;
@synthesize m_pageControllUsed;
@synthesize m_viewArr;
@synthesize m_rRoomProObjArr;

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
    
//    self.m_detailView.layer.cornerRadius = 4;
//	self.m_detailView.layer.masksToBounds = YES;
//	self.m_detailView.layer.borderWidth = 1;
//	self.m_detailView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
 //   self.m_otherBulbArr = [[NSMutableArray alloc] init];
    
//    
//    for (int i=0; i<10; i++) {
//        BulbDetailParam* temBulb = [[BulbDetailParam alloc] init];
//        
//        temBulb.m_image = [[UIImage imageNamed:@"room1.png"] retain];
//        temBulb.m_param1 = [[NSString alloc] initWithFormat:@"第（%d）个灯泡 参数1",i+1];
//        temBulb.m_param2 = [[NSString alloc] initWithFormat:@"第（%d）个灯泡 参数2",i+1];
//        temBulb.m_param3 = [[NSString alloc] initWithFormat:@"第（%d）个灯泡 参数3",i+1];
//        temBulb.m_param4 = [[NSString alloc] initWithFormat:@"第（%d）个灯泡 参数4",i+1];
//        temBulb.m_param5 = [[NSString alloc] initWithFormat:@"第（%d）个灯泡 参数5",i+1];
//        temBulb.m_param6 = [[NSString alloc] initWithFormat:@"第（%d）个灯泡 参数6",i+1];
//        temBulb.m_param7 = [[NSString alloc] initWithFormat:@"第（%d）个灯泡 参数7",i+1];
//        [self.m_otherBulbArr addObject:temBulb];
//        
//        [temBulb release];
//        
//    }
    UISwipeGestureRecognizer* recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];
    
//    [self initRoomTable];
//    [self initProductTable];
//    [self initPosTable];
////    
////    NSString* filepath1 = [[DataProcess getDocumentsPath] stringByAppendingPathComponent:@"data.sqlite3"];
////    NSString* filepath2 = [[DataProcess getMainPath] stringByAppendingPathComponent:@"data.sqlite3"];
////    
////    NSData* data = [NSData dataWithContentsOfFile:filepath2];
////    
////    [[NSFileManager defaultManager] createFileAtPath:filepath1 contents:data attributes:nil];
////    
// 
//    
// //   [self initScrollView];
//    
////    
////    [self parserBlubStr];
////    
//    
//    
//    [self getPrintPosTable];
//    [self getPrintRoomTable];
//    [self getPrintProductTable];
    

}

-(void) initImageView
{
    if (self.m_viewArr) {
        [self.m_viewArr release];
        self.m_viewArr =nil;
    }
    
    self.m_viewArr = [[NSMutableArray alloc] init];
    
    RoomTableObj* temobj = [DataBase GetSingleRoomTableObj];
    //初始化 房间的 所有 图片和 按钮－－－－－－－－－－－－－－－
    
    NSMutableArray* arr = temobj.m_imageTableObjArr;
    if (arr.count <= 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Warning message" message:@"No picture information in the room." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        self.m_imageCount = 0;
        return;
    }
    
    self.m_imageCount = arr.count;
    for (int i=0; i<arr.count; i++) {
        
        ImageTableObj* imageObj = [arr objectAtIndex:i];
        
        UIView* roomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 704)];
        NSString* path = [DataProcess getImageFilePathByUrl:imageObj.m_imageUrl];
        
        NSLog(@"path = %@",path);
        
        UIImage* image = [UIImage imageWithContentsOfFile:path];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        [roomView addSubview:imageView];
        [imageView release];
        
        imageObj.m_posTableObjArr = [DataBase getPosTableInfoImgeId:imageObj.m_imageId];
        
        NSMutableArray* posArr = imageObj.m_posTableObjArr;
        for (int j=0; j<posArr.count; j++) {
            PosTableObj* posObj = [posArr objectAtIndex:j];
            UIButton* tembutton = [[UIButton alloc] initWithFrame:CGRectMake(posObj.m_posX.intValue, posObj.m_posY.intValue, 50, 50)];
            
            [tembutton setImage:[UIImage imageNamed:@"pos_hot.png"] forState:UIControlStateNormal];
            [tembutton setShowsTouchWhenHighlighted:YES];
            [tembutton addTarget:self action:@selector(lampOneButton:) forControlEvents:UIControlEventTouchUpInside];
            tembutton.tag = j;
            [roomView addSubview:tembutton];
            [tembutton release];
            
        }
        
        
        roomView.tag = i;
        [self.m_viewArr addObject:roomView];
        [roomView release];
    }
    
    
    
    
    
}

-(void) handleSwipeFrom:(UISwipeGestureRecognizer*) recognizer
{
    //200 毫秒用来 显示 滑动 速率
    CFTimeInterval temTime = CFAbsoluteTimeGetCurrent();
    
    if (temTime-m_lastTimeDouble <=0.2) {
        NSLog(@"-------------------------");
        return;
    }
    
    m_lastTimeDouble = temTime;
    
    NSLog(@"*****************");
    //  return;
    
    int swipflag = 0;
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        
        swipflag = 0;
        [self loadOtherRoomImageInfo:[DataBase GetSingleRoomTableObj].m_roomId Flag:swipflag];
    }else if(recognizer.direction == UISwipeGestureRecognizerDirectionUp){
        
        swipflag = 1;
        [self loadOtherRoomImageInfo:[DataBase GetSingleRoomTableObj].m_roomId Flag:swipflag];
    }
    
    
}


-(void) loadOtherRoomImageInfo:(NSString*) roomid Flag:(int) flag
{
    int maxvalue = 0;
    NSString* maxstr = [roomid substringToIndex:1];
    if (0 == [maxstr compare:@"A"]) {
        maxvalue = 9;
    }else if (0 == [maxstr compare:@"B"]) {
        maxvalue = 12;
    }else if (0 == [maxstr compare:@"C"]) {
        maxvalue = 10;
    }
 

    //设置标题
    
    RoomTableObj* temobj = [DataBase GetSingleRoomTableObj];
    
    NSString* str = [roomid substringFromIndex:1];
    int index = [str intValue];
    int temflag = 0;
    
    NSString* nextroomid = nil;
    if (1 == flag) {
        for (int i=index+1; i<=maxvalue; i++) {
            
            nextroomid = [NSString stringWithFormat:@"%@%d",[roomid substringToIndex:1],i];
            NSArray* arr = [DataBase getImageTableInfoRoomid:nextroomid];
            
            if (!arr || arr.count <= 0) {
                
                continue;
            }else{
                temobj.m_imageTableObjArr = [[NSMutableArray alloc] initWithArray:arr];
                temflag = 1;
                break;
            }
            
        }
        
    }else{
        for (int i=index-1; i>=1; i--) {
            
            nextroomid = [NSString stringWithFormat:@"%@%d",[roomid substringToIndex:1],i];
            NSArray* arr = [DataBase getImageTableInfoRoomid:nextroomid];
            
            if (!arr || arr.count <= 0) {
                
                continue;
            }else{
                temobj.m_imageTableObjArr = [[NSMutableArray alloc] initWithArray:arr];
                temflag = 1;
                break;
            }
            
        }
    }
    
    if (temflag == 0) {
        return;
    }
    
    [temobj setRoomNameByRoomId:nextroomid];
    
    self.m_navItem.title = temobj.m_roomName;    
    
    
    [self initImageView];
    [self initPageScrollView];
}


-(void) initPageScrollView
{
    if (self.m_imageCount <= 0) {
        return;
    }
    // a page is the width of the scroll view
    self.m_mainRoomScrollView.pagingEnabled = YES;
    self.m_mainRoomScrollView.contentSize = CGSizeMake(self.m_mainRoomScrollView.frame.size.width * self.m_imageCount, self.m_mainRoomScrollView.frame.size.height);
    self.m_mainRoomScrollView.showsHorizontalScrollIndicator = NO;
    self.m_mainRoomScrollView.showsVerticalScrollIndicator = NO;
    self.m_mainRoomScrollView.scrollsToTop = NO;
    self.m_mainRoomScrollView.delegate = self;
//    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView)];
//    
//    [self.m_scrollView addGestureRecognizer:gesture];
//    [gesture release];
    
    self.m_pageControl.numberOfPages = self.m_imageCount;
    self.m_pageControl.currentPage = 0;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    ImageTableObj* imageobj = [[DataBase GetSingleRoomTableObj].m_imageTableObjArr objectAtIndex:0];
    self.m_desTextView.text = imageobj.m_description;
    
    
}

- (void)viewDidUnload
{
    [self setM_detailView:nil];
    [self setM_shadeView:nil];
    [self setM_mainView:nil];
    [self setM_imageScrollView:nil];
    [self setM_bulbParam1:nil];
    [self setM_bulbParam2:nil];
    [self setM_bulbParam3:nil];
    [self setM_bulbParam4:nil];
    [self setM_bulbParam5:nil];
    [self setM_bulbParam6:nil];
    [self setM_bulbParam7:nil];
    [self setM_roomImageScrollView:nil];
    [self setM_pullButton:nil];
    [self setM_roomLeftView:nil];
    [self setM_mainRoomScrollView:nil];
    [self setM_pageControl:nil];
    [self setM_page1View:nil];
    [self setM_navItem:nil];
    [self setM_selectBulbImageView:nil];
    [self setM_bulbParam8:nil];
    [self setM_bulbParam9:nil];
    [self setM_imageInfoView:nil];
    [self setM_imageInfoLabel:nil];
    [self setM_paramScrollView:nil];
    [self setM_desTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) threadFun:(id) obj
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    int value = ((NSString*)obj).intValue;
    switch (value) {
        case 1:
        {
            NSString* path = [[DataProcess getMainPath] stringByAppendingPathComponent:@"hallInfo.xml"];
            NSError*error;
            NSString* str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            
            NSArray* posarr = [MyXMLParser DecodeToObj:str];
            
            for (int i=0; i<posarr.count; i++) {
                ProductTableObj* posobj = [posarr objectAtIndex:i];
                NSLog(@" id = %@",posobj.m_bulbId);
            }
        }
            break;
        case 2:
        {
            NSString* path = [[DataProcess getMainPath] stringByAppendingPathComponent:@"hallInfo1.xml"];
            NSError*error;
            NSString* str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            
            NSArray* posarr = [MyXMLParser DecodeToObj:str];
            
            for (int i=0; i<posarr.count; i++) {
                ImageTableObj* posobj = [posarr objectAtIndex:i];
                NSLog(@" id = %@",posobj.m_imageId);
            }
        }
            
            break;
        case 3:
        {
            NSString* path = [[DataProcess getMainPath] stringByAppendingPathComponent:@"hallInfo2.xml"];
            NSError*error;
            NSString* str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            
            NSArray* posarr = [MyXMLParser DecodeToObj:str];
            
            for (int i=0; i<posarr.count; i++) {
                PosTableObj* posobj = [posarr objectAtIndex:i];
                NSLog(@" id = %@",posobj.m_posId);
            }
        }
            break;
        case 4:
        {
            NSString* path = [[DataProcess getMainPath] stringByAppendingPathComponent:@"hallInfo3.xml"];
            NSError*error;
            NSString* str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            
            NSString* posarr = [MyXMLParser DecodeToObj:str];
            NSLog(@" posarr = %@",posarr);
                        
        }
            break;
            
        default:
            break;
    }
    
    [pool release];
     
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.m_detailView setHidden:YES];
    //设置标题
    self.m_navItem.title = [DataBase GetSingleRoomTableObj].m_roomName;
    
//    NSMutableArray* ar = [[NSMutableArray alloc] init];
//    
//    ProductTableObj* aa = [[ProductTableObj alloc] init];
//    aa.m_bulbVersionId = @"456";
//    aa.m_bulbId = @"wo 我";
//    
//    ProductTableObj* bb = [[ProductTableObj alloc] init];
//    bb.m_bulbVersionId = @"45677777";
//    bb.m_bulbId = @"wo 我5656";
//
//    [ar addObject:aa];
//    [ar addObject:bb];
//    
//    NSLog(@"zifuchuan : %@ !!",[MyXMLParser EncodeToStr:@"我阿桑f123" Type:@"version"]);
//    
//    NSLog(@"zifuchuan : %@ ++",[MyXMLParser EncodeToStr:ar Type:@"product"]);
    
    [self initImageView];
    [self initPageScrollView];
    
 //   [self initAllImageAndPosData];
    
//    
//
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"1"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"2"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"3"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"4"];
//    
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"2"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"3"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"4"];
//    
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"2"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"3"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"4"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"1"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"1"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"1"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"1"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"1"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"1"];
//    [NSThread detachNewThreadSelector:@selector(threadFun:) toTarget:self withObject:@"1"];
//    //[self requestHttp];
//    
//
//        [NSThread detachNewThreadSelector:@selector(downFileTest) toTarget:self withObject:nil];

    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.m_detailView setHidden:YES];
    
}

-(void) downFileTest
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    NSString* urlStr = @"http://59.57.250.98:8400/DisplayPic/r6/r_ar6-7999-1.jpg";
    for (int i=0; i<10; i++) {
   BOOL suc = [DataProcess downAndWriteImgeforUrl:urlStr];
    }
    [pool release];
}



-(void) initScrollView
{
    int startoff = -2;
    
    int roomStartOff = -2;
    
    for (int i=0; i<[self.m_otherBulbArr count]; i++) {
        BulbDetailParam* temBulb = (BulbDetailParam*)[self.m_otherBulbArr objectAtIndex:i];
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(startoff + 2*1, 0, 170, 140)];
        button.tag = i;
        [button addTarget:self action:@selector(imageSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:temBulb.m_image forState:UIControlStateNormal];
        [self.m_imageScrollView addSubview:button];
        [button release];
        
        startoff += 170 + 2*1;
        
        UIButton* button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, roomStartOff + 2*1, 175, 117)];
        button2.tag = i+1;

        [button2 setImage:temBulb.m_image forState:UIControlStateNormal];
        [self.m_roomImageScrollView addSubview:button2];
        [button2 release];
        
        roomStartOff += 117 + 2*1;
        
        
    }
    
    [self.m_imageScrollView setContentSize:CGSizeMake(startoff+2, 100)];
    [self.m_roomImageScrollView setContentSize:CGSizeMake(100, roomStartOff+2)];
    
}

-(void) initProductScrollView
{
    
    for (UIView* temview in self.m_imageScrollView.subviews) {
        [temview removeFromSuperview];
    }
    
    int startoff = -2;
    
    for (int i=0; i<[self.m_rRoomProObjArr count]; i++) {
        ProductTableObj* temBulb = (ProductTableObj*)[self.m_rRoomProObjArr objectAtIndex:i];
        
        
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(startoff + 4*1, 1, 50, 76)];
        button.tag = i;
        [button addTarget:self action:@selector(imageSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString* path = [DataProcess getImageFilePathByUrl:temBulb.m_bulbImage];
        
        NSLog(@"path = %@",path);
        
        UIImage* image = [UIImage imageWithContentsOfFile:path];
        if (i == 0) {
            self.m_selectBulbImageView.image = image;
            
            if (self.m_selectBulbImageView.image.size.width >= 216 || self.m_selectBulbImageView.image.size.height >= 330) {
                if (self.m_selectBulbImageView.image.size.width >= 216) {
                    float scale = self.m_selectBulbImageView.image.size.width/216.0;
                    [self.m_selectBulbImageView setFrame:CGRectMake(8, 47, 216, self.m_selectBulbImageView.image.size.height/scale)];
                }else {
                    float scale = self.m_selectBulbImageView.image.size.height/330.0;
                    [self.m_selectBulbImageView setFrame:CGRectMake(8, 47, self.m_selectBulbImageView.image.size.width/scale, 330)];
                }
                
            }else {
                
                [self.m_selectBulbImageView setFrame:CGRectMake(8, 47, self.m_selectBulbImageView.image.size.width, self.m_selectBulbImageView.image.size.height)];
            }
            [self.m_selectBulbImageView setCenter:CGPointMake(116, 212)];
             NSArray* temarr = [temBulb.m_bulbParam componentsSeparatedByString:paramSeparetedStr];
            [self initParamScrollView:temarr];
//            
//            
//           
//            @try {
//                self.m_bulbParam1.text = nil;
//                self.m_bulbParam2.text = nil;
//                self.m_bulbParam3.text = nil;
//                self.m_bulbParam4.text = nil;
//                self.m_bulbParam5.text = nil;
//                self.m_bulbParam6.text = nil;
//                self.m_bulbParam7.text = nil;
//                self.m_bulbParam8.text = nil;
//                self.m_bulbParam9.text = nil;
//                self.m_bulbParam1.text = [temarr objectAtIndex:0];
//                self.m_bulbParam2.text = [temarr objectAtIndex:1];
//                self.m_bulbParam3.text = [temarr objectAtIndex:2];
//                self.m_bulbParam4.text = [temarr objectAtIndex:3];
//                self.m_bulbParam5.text = [temarr objectAtIndex:4];
//                self.m_bulbParam6.text = [temarr objectAtIndex:5];
//                self.m_bulbParam7.text = [temarr objectAtIndex:6];
//                self.m_bulbParam8.text = [temarr objectAtIndex:7];
//                self.m_bulbParam9.text = [temarr objectAtIndex:8];
//            }
//            @catch (NSException *exception) {
//                NSLog(@"设置灯泡参数时 出现异常 11 ");
//            }
//            @finally {
//                
//            }
            
            //   self.m_bulbParam1.text = temBulb.m_bulbParam;
        }
        
        [button setImage:image forState:UIControlStateNormal];
        [self.m_imageScrollView addSubview:button];
        [button release];
        
        startoff += 50 + 4*1;
        
    }
    
    [self.m_imageScrollView setContentSize:CGSizeMake(startoff+4, 50)];
}

-(void) initParamScrollView:(NSArray*) arr
{
    for (UIView* view in [self.m_paramScrollView subviews]){
        [view removeFromSuperview];
    }
    
    
    int startVerOff = 10;
    
    for (int i=0; i<arr.count; i++) {
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(50, startVerOff, 300, 21)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentLeft;
        label.font = [UIFont fontWithName:@"System" size:17];
        label.text = [arr objectAtIndex:i];
        [self.m_paramScrollView addSubview:label];
        [label release];
        
        startVerOff += 30;
        
        
    }
    [self.m_paramScrollView setContentSize:CGSizeMake(20, startVerOff)];
   
}


-(void) parserBlubStr
{
    NSString* str = [NSString stringWithString:XMLSTR];
    
    NSLog(XMLSTR);
    
    S_Data temdata;
    xmlparser::Decode([str UTF8String], &temdata);
    
    RoomInformation* roominfo = [[RoomInformation alloc] init];
    
    [roominfo initArrWithData:&temdata];
    
    NSLog(@" count = %d",roominfo.m_bulbInforArr.count);
    
    temdata.clean();
    temdata.commandName = "主动请求服务器";
    temdata.params["sadfasdf"] = "123456";
    temdata.params["123"] = "456";
    
    string encodeStr;
    xmlparser::Encode(&temdata, encodeStr);
    
    NSString* obcstr = [NSString stringWithCString:encodeStr.c_str() encoding:NSUTF8StringEncoding];
    
    NSLog(@"编码 发送的字符串：%@",obcstr);
    
    
    
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    
    return NO;
}

-(void) imageSelectButton:(id)sender
{
    NSLog(@"tag = %d",((UIButton*)sender).tag);
    
    int tag = ((UIButton*)sender).tag;
    
    UIButton* button = (UIButton*)sender;
    self.m_selectBulbImageView.image = button.imageView.image;
    
    if (self.m_selectBulbImageView.image.size.width >= 216 || self.m_selectBulbImageView.image.size.height >= 252) {
        
        if (self.m_selectBulbImageView.image.size.width >= 216) {
            float scale = self.m_selectBulbImageView.image.size.width/216.0;
            [self.m_selectBulbImageView setFrame:CGRectMake(8, 47, 216, self.m_selectBulbImageView.image.size.height/scale)];
        }else {
            float scale = self.m_selectBulbImageView.image.size.height/252.0;
            [self.m_selectBulbImageView setFrame:CGRectMake(8, 47, self.m_selectBulbImageView.image.size.width/scale, 252)];
        }
        
    }else {
        
        [self.m_selectBulbImageView setFrame:CGRectMake(8, 47, self.m_selectBulbImageView.image.size.width, self.m_selectBulbImageView.image.size.height)];
    }
    
    
    [self.m_selectBulbImageView setCenter:CGPointMake(116, 212)];
    
    ProductTableObj* proobj = [self.m_rRoomProObjArr objectAtIndex:tag];
    
    //self.m_bulbParam1.text = proobj.m_bulbParam;
    
    NSArray* temarr = [proobj.m_bulbParam componentsSeparatedByString:paramSeparetedStr];
    
    [self initParamScrollView:temarr];
    
//    @try {
//        self.m_bulbParam1.text = nil;
//        self.m_bulbParam2.text = nil;
//        self.m_bulbParam3.text = nil;
//        self.m_bulbParam4.text = nil;
//        self.m_bulbParam5.text = nil;
//        self.m_bulbParam6.text = nil;
//        self.m_bulbParam7.text = nil;
//        self.m_bulbParam8.text = nil;
//        self.m_bulbParam9.text = nil;
//        self.m_bulbParam1.text = [temarr objectAtIndex:0];
//        self.m_bulbParam2.text = [temarr objectAtIndex:1];
//        self.m_bulbParam3.text = [temarr objectAtIndex:2];
//        self.m_bulbParam4.text = [temarr objectAtIndex:3];
//        self.m_bulbParam5.text = [temarr objectAtIndex:4];
//        self.m_bulbParam6.text = [temarr objectAtIndex:5];
//        self.m_bulbParam7.text = [temarr objectAtIndex:6];
//        self.m_bulbParam8.text = [temarr objectAtIndex:7];
//        self.m_bulbParam9.text = [temarr objectAtIndex:8];
//    }
//    @catch (NSException *exception) {
//        NSLog(@"设置灯泡参数时 出现异常");
//    }
//    @finally {
//        
//    }
//    
//    
    
}

- (IBAction)imageInfoButtonAction:(id)sender 
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.m_imageInfoView.center = self.view.center;
        self.m_shadeView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    return;

}

- (IBAction)closeImageInfoView:(id)sender 
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = self.m_imageInfoView.frame;
        rect.origin.y = 748;
        
        [self.m_imageInfoView setFrame:rect];
        self.m_shadeView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
    
    return;

}

- (IBAction)pullButton:(id)sender {
    
    CGRect rect = self.m_roomLeftView.frame;
    CGRect rect2 = self.m_pullButton.frame;
    if (rect.origin.x+rect.size.width > 0) {
        rect.origin.x = -1 * rect.size.width;
        rect2.origin.x = 0;
        [self.m_pullButton setImage:[UIImage imageNamed:@"left_state1.png"] forState:UIControlStateNormal];
    }else{
        rect.origin.x = 0;
        rect2.origin.x = rect.size.width;
        [self.m_pullButton setImage:[UIImage imageNamed:@"left_state2.png"] forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.m_roomLeftView.frame = rect;
        self.m_pullButton.frame = rect2;
        
    } completion:^(BOOL finished) {
        
    }];

    
}

- (IBAction)lampOneButton:(id)sender 
{
//    
//    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
//    [delegate entryDetail];
    
//    DetailViewController* detail = [[DetailViewController alloc] init];
//    [self presentModalViewController:detail animated:YES];
    
   

    
    
    UIButton* button = (UIButton*)sender;
    
    UIView* imageView = [button superview];
    
    
    PosTableObj* posObj = [((ImageTableObj*)[[DataBase  GetSingleRoomTableObj].m_imageTableObjArr objectAtIndex:imageView.tag]).m_posTableObjArr objectAtIndex:button.tag];
    
    NSString* posid = posObj.m_posId;
    
    
    NSArray* temarr = [DataBase getTypeTableInfoPosId:posid];
    
    if (self.m_rRoomProObjArr) {
        [self.m_rRoomProObjArr release];
        self.m_rRoomProObjArr = nil;
    }
    self.m_rRoomProObjArr = [[NSMutableArray alloc] init];
    
    ProductTableObj* firstObj = nil;
    
    int firstObjIndex = 0;
    
    for (int i=0; i<temarr.count; i++) {
        
        TypeTableObj* typeobj = [temarr objectAtIndex:i];
        
        
        
        ProductTableObj* temPro = [DataBase getOneBulbTableInfo:typeobj.m_bulbId];
        if (0 == [posObj.m_bulbId compare:typeobj.m_bulbId]) {
            firstObj = temPro;
            firstObjIndex = i;
        }
        [self.m_rRoomProObjArr addObject:temPro];
        
    }

    if (!temarr || temarr.count<=0 || !self.m_rRoomProObjArr || self.m_rRoomProObjArr.count<=0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Prompt Message" message:@"Did not find the product information" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        return;
    }

    @try {
        if (firstObj) {
            
            
            //交换位置
            [self.m_rRoomProObjArr exchangeObjectAtIndex:0 withObjectAtIndex:firstObjIndex];
            
            //[self.m_rRoomProObjArr insertObject:firstObj atIndex:0];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[self.m_rRoomProObjArr insertObject:firstObj atIndex:0];   产生异常！！");
    }
    @finally {
        
    }
    
    
    
    
    [self.m_detailView setHidden:NO];
    self.m_mainView.userInteractionEnabled=NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.m_detailView.center = self.view.center;
        self.m_shadeView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
    }];
    
/*    NSString* proid = posObj.m_bulbId;
    
    ProductTableObj* proObj = [DataBase getOneBulbTableInfo:proid];
    
    if (self.m_rRoomProObjArr) {
        [self.m_rRoomProObjArr release];
        self.m_rRoomProObjArr = nil;
    }
    self.m_rRoomProObjArr = [[NSMutableArray alloc] initWithArray:[DataBase getBulbTableObjByProtype:proObj.m_bulbType]];
    
   */
    
    
    
    [self initProductScrollView];
    
}

- (IBAction)close:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)closeModelView:(id)sender {
    
    self.m_mainView.userInteractionEnabled=YES;
    
    [UIView animateWithDuration:0.3 animations:^{

        CGRect rect = self.m_detailView.frame;
        rect.origin.x = -1*rect.size.width;
        
        [self.m_detailView setFrame:rect];
         self.m_shadeView.alpha = 0.0;
    } completion:^(BOOL finished) {
    
    }];

}

- (IBAction)changePge:(id)sender 
{
    int page = self.m_pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = self.m_mainRoomScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.m_mainRoomScrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    self.m_pageControllUsed = YES;

    
}


- (void)dealloc {
    [m_detailView release];
    [m_shadeView release];
    [m_mainView release];
    [m_imageScrollView release];
    [m_otherBulbArr release];
    
    [m_viewArr release];
    
    [m_bulbParam1 release];
    [m_bulbParam2 release];
    [m_bulbParam3 release];
    [m_bulbParam4 release];
    [m_bulbParam5 release];
    [m_bulbParam6 release];
    [m_bulbParam7 release];
    
    [m_http release];
    [m_roomImageScrollView release];
    [m_pullButton release];
    [m_roomLeftView release];
    [m_mainRoomScrollView release];
    [m_pageControl release];
    [m_page1View release];
    
    [m_rRoomProObjArr release];
    
    [m_navItem release];
    [m_selectBulbImageView release];
    [m_bulbParam8 release];
    [m_bulbParam9 release];
    [m_imageInfoView release];
    [m_imageInfoLabel release];
    [m_paramScrollView release];
    [m_desTextView release];
    [super dealloc];
}

-(void) initPosTable
{
//    for (int i=0; i<100; i++) {
//        
//        PosTableObj* posObj = [[PosTableObj alloc] init];
//        posObj.m_roomId = [[NSString alloc] initWithFormat:@"m_roomId+%d",i+1];
//        posObj.m_hallId = [[NSString alloc] initWithFormat:@"m_hallId+%d",i+1];
//        posObj.m_posId = [[NSString alloc] initWithFormat:@"m_posId+%d",i+1];
//        posObj.m_bulbId = [[NSString alloc] initWithFormat:@"m_bulbId+%d",i+1];
//        posObj.m_posX = [[NSString alloc] initWithFormat:@"m_posX+%d",i+1];
//        posObj.m_posY = [[NSString alloc] initWithFormat:@"m_posY+%d",i+1];
//        posObj.m_versionId = [[NSString alloc] initWithFormat:@"m_versionId+%d",i+1];
//        posObj.m_orderId = [[NSString alloc] initWithFormat:@"m_orderId+%d",i+1];
//        
//        [DataBase addPosTableObj:posObj];
//        
//        [posObj release];
//
//    }
    
}

-(void) initRoomTable
{
//    for (int i=0; i<100; i++) {
//     
//        RoomTableObj* roomObj = [[RoomTableObj alloc] init];
//        roomObj.m_roomId = [[NSString alloc] initWithFormat:@"m_roomId+%d",i+1];
//        roomObj.m_hallImage = [[NSString alloc] initWithFormat:@"m_hallImage+%d",i+1];
//        roomObj.m_orderId = [[NSString alloc] initWithFormat:@"m_orderId+%d",i+1];
//        roomObj.m_description = [[NSString alloc] initWithFormat:@"m_description+%d",i+1];
//        roomObj.m_versionId = [[NSString alloc] initWithFormat:@"m_versionId+%d",i+1];
//        
//        
//        [DataBase addRoomTableObj:roomObj];
//        
//        [roomObj release];
//       
//    }
    
}
-(void) initProductTable
{
//    for (int i=0; i<100; i++) {
//        
//        ProductTableObj* roomObj = [[ProductTableObj alloc] init];
//        roomObj.m_bulbId = [[NSString alloc] initWithFormat:@"m_bulbId+%d",i+1];
//        roomObj.m_bulbImage = [[NSString alloc] initWithFormat:@"m_bulbImage+%d",i+1];
//        roomObj.m_bulbName = [[NSString alloc] initWithFormat:@"m_bulbName+%d",i+1];
//        roomObj.m_bulbParam = [[NSString alloc] initWithFormat:@"m_bulbParam+%d",i+1];
//        roomObj.m_bulbType = [[NSString alloc] initWithFormat:@"m_bulbType+%d",i+1];
//        roomObj.m_bulbVersionId = [[NSString alloc] initWithFormat:@"m_bulbVersionId+%d",i+1];
//        
//        
//        [DataBase addProductTableObj:roomObj];
//        
//        [roomObj release];
//        
//    }
}

-(void) initAllImageAndPosData
{
    RoomTableObj* temobj = [DataBase GetSingleRoomTableObj];
    temobj.m_imageTableObjArr = [[NSMutableArray alloc] initWithArray:[DataBase getImageTableInfoRoomid:temobj.m_roomId]];
            
    for (int i=0; i<temobj.m_imageTableObjArr.count; i++) {
        
        ImageTableObj* temImageObj = [temobj.m_imageTableObjArr objectAtIndex:i];
        
        temImageObj.m_posTableObjArr = [[NSMutableArray alloc] initWithArray:[DataBase getPosTableInfoImgeId:temImageObj.m_imageId]];
        
        
    }
    
    
    
}

-(void) getPrintPosTable
{
//    NSArray* room1 = [DataBase getAllPosTableObj];
//    for (int i=0; i<room1.count; i++) {
//        PosTableObj* posObj = (PosTableObj*)[room1 objectAtIndex:i];
//        NSLog(@"[DataBase getAllPosTableObj] : roomid = %@,m_hallId = %@,m_posId = %@,m_bulbId = %@,m_posX = %@,m_posY = %@,m_versionId = %@,m_orderId = %@.",posObj.m_roomId,posObj.m_hallId,posObj.m_posId,posObj.m_bulbId,posObj.m_posX,posObj.m_posY,posObj.m_versionId,posObj.m_orderId);
//
//    }
//    
//    
//    room1 = [DataBase getOnePosTableInfo:@"m_hallId+3"];
//    for (int i=0; i<room1.count; i++) {
//        PosTableObj* posObj = (PosTableObj*)[room1 objectAtIndex:i];
//        NSLog(@"[DataBase getAllPosTableObj] : roomid = %@,m_hallId = %@,m_posId = %@,m_bulbId = %@,m_posX = %@,m_posY = %@,m_versionId = %@,m_orderId = %@.",posObj.m_roomId,posObj.m_hallId,posObj.m_posId,posObj.m_bulbId,posObj.m_posX,posObj.m_posY,posObj.m_versionId,posObj.m_orderId);
//        
//    }
//
//    room1 = [DataBase getOnePosTableInfo:@"m_hallId+5" Room:@"m_roomId+5"];
//    for (int i=0; i<room1.count; i++) {
//        PosTableObj* posObj = (PosTableObj*)[room1 objectAtIndex:i];
//        NSLog(@"[DataBase getAllPosTableObj] : roomid = %@,m_hallId = %@,m_posId = %@,m_bulbId = %@,m_posX = %@,m_posY = %@,m_versionId = %@,m_orderId = %@.",posObj.m_roomId,posObj.m_hallId,posObj.m_posId,posObj.m_bulbId,posObj.m_posX,posObj.m_posY,posObj.m_versionId,posObj.m_orderId);
//        
//    }
//    
//    PosTableObj* posObj = [DataBase getOnePosTableInfo:@"m_hallId+10" Room:@"m_roomId+10" Bulb:@"m_bulbId+10"];
//
//        NSLog(@"[DataBase getAllPosTableObj] : roomid = %@,m_hallId = %@,m_posId = %@,m_bulbId = %@,m_posX = %@,m_posY = %@,m_versionId = %@,m_orderId = %@.",posObj.m_roomId,posObj.m_hallId,posObj.m_posId,posObj.m_bulbId,posObj.m_posX,posObj.m_posY,posObj.m_versionId,posObj.m_orderId);

}

-(void) getPrintRoomTable
{
//    NSArray* room1 = [DataBase getAllRoomTableObj];
//    for (int i=0; i<room1.count; i++) {
//        RoomTableObj* temObj = (RoomTableObj*)[room1 objectAtIndex:i];
//        NSLog(@"[DataBase getAllRoomTableObj] : roomid = %@,hallImge = %@,bulbid = %@,posx = %@,posy = %@,versionid = %@.",temObj.m_roomId,temObj.m_hallImage,temObj.m_description,temObj.m_orderId,temObj.m_versionId);
//    }
//    
//    room1 = [DataBase getOneRoomTableInfo:@"m_roomId+3"];
//    for (int i=0; i<room1.count; i++) {
//        RoomTableObj* temObj = (RoomTableObj*)[room1 objectAtIndex:i];
//        NSLog(@"1个参数  : roomid = %@,hallImge = %@,bulbid = %@,posx = %@,posy = %@,versionid = %@.",temObj.m_roomId,temObj.m_hallImage,temObj.m_bulbId,temObj.m_posX,temObj.m_posY,temObj.m_versionId);
//    }
//    
//    
//    
//    self.m_roomId = nil;
//    self.m_versionId = nil;
//    self.m_hallImage = nil;
//    self.m_orderId = nil;
//    self.m_description = nil;
//    
//    room1 = [DataBase getOneRoomTableInfo:@"m_roomId+10" ImageName:@"m_hallImage+10"];
//    for (int i=0; i<room1.count; i++) {
//        RoomTableObj* temObj = (RoomTableObj*)[room1 objectAtIndex:i];
//        NSLog(@"2个 参数 : roomid = %@,hallImge = %@,bulbid = %@,posx = %@,posy = %@,versionid = %@.",temObj.m_roomId,temObj.m_hallImage,temObj.m_bulbId,temObj.m_posX,temObj.m_posY,temObj.m_versionId);
//    }
//    
//     RoomTableObj* temObj = [DataBase getOneRoomTableInfo:@"m_roomId+33" ImageName:@"m_hallImage+33" Bulb:@"m_bulbId+33"];
//    
//    NSLog(@"3个 参数 : roomid = %@,hallImge = %@,bulbid = %@,posx = %@,posy = %@,versionid = %@.",temObj.m_roomId,temObj.m_hallImage,temObj.m_bulbId,temObj.m_posX,temObj.m_posY,temObj.m_versionId);
//
}
-(void) getPrintProductTable
{
//    NSArray* bulbarr = [DataBase getAllBulbTableObj];
//    for (int i=0; i<bulbarr.count; i++) {
//        ProductTableObj* temObj = (ProductTableObj*)[bulbarr objectAtIndex:i];
//        NSLog(@"[DataBase getAllBulbTableObj] : m_bulbId = %@,m_bulbImage = %@,m_bulbName = %@,m_bulbParam = %@,m_bulbType = %@,m_bulbVersionId = %@.",temObj.m_bulbId,temObj.m_bulbImage,temObj.m_bulbName,temObj.m_bulbParam,temObj.m_bulbType,temObj.m_bulbVersionId);
//    }
//    
//
//    
//    ProductTableObj* temObj = [DataBase getOneBulbTableInfo:@"m_bulbId+55"];
//    
//    NSLog(@"1个参数 : m_bulbId = %@,m_bulbImage = %@,m_bulbName = %@,m_bulbParam = %@,m_bulbType = %@,m_bulbVersionId = %@.",temObj.m_bulbId,temObj.m_bulbImage,temObj.m_bulbName,temObj.m_bulbParam,temObj.m_bulbType,temObj.m_bulbVersionId);
//    
       
}







- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= self.m_imageCount)
        return;
    
    // replace the placeholder if necessary
    UIView* temview = [self.m_viewArr objectAtIndex:page];
    

    // add the controller's view to the scroll view
    if (temview.superview == nil)
    {
        CGRect frame = self.m_mainRoomScrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        temview.frame = frame;
        [self.m_mainRoomScrollView addSubview:temview];
        //        
        //        NSDictionary *numberItem = [self.contentList objectAtIndex:page];
        //        controller.numberImage.image = [UIImage imageNamed:[numberItem valueForKey:ImageKey]];
        //        controller.numberTitle.text = [numberItem valueForKey:NameKey];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (self.m_mainRoomScrollView != sender) {
        return;
    }
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (self.m_pageControllUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.m_mainRoomScrollView.frame.size.width;
    
    
    //下取整
    int page = floor((self.m_mainRoomScrollView.contentOffset.x + pageWidth / 2) / pageWidth);
    self.m_pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    ImageTableObj* imageobj = [[DataBase GetSingleRoomTableObj].m_imageTableObjArr objectAtIndex:page];
    self.m_desTextView.text = imageobj.m_description;
    
    NSLog(@"contentOffset = %f, page = %d",self.m_mainRoomScrollView.contentOffset.x,page);
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.m_mainRoomScrollView != scrollView) {
        return;
    }
    self.m_pageControllUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.m_mainRoomScrollView != scrollView) {
        return;
    }
    self.m_pageControllUsed = NO;
}



-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 //   [self close:nil];
}



#pragma mark -
#pragma mark Http


@end

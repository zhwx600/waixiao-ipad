//
//  ViewController.m
//  LiDaXin-iPad
//
//  Created by apple on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "myimgeview.h"


#define RADIUS 200.0
#define PHOTONUM 3
#define PHOTOSTRING @"hallMenu_"
#define TAGSTART 1000
#define TIME 1.5
#define SCALENUMBER 1.25
//int array [PHOTONUM][PHOTONUM] ={
//	{0,1,2,3,4},
//	{4,0,1,2,3},
//	{3,4,0,1,2},
//	{2,3,4,0,1},
//	{1,2,3,4,0}
//};

int array [PHOTONUM][PHOTONUM] ={
	{0,1,2},
	{2,0,1},
	{1,2,0},
};

#define ITEM_SPACING 598

@interface ViewController ()

@end

@implementation ViewController
@synthesize colseInforView;
@synthesize m_infoView;
@synthesize genieView;
@synthesize m_infoButton;
@synthesize m_tishiImageView;
@synthesize isShow;
@synthesize m_shengjiAlertView;
@synthesize m_downPosArr,m_downImageArr,m_downProductArr,m_downTypeArr,m_downVersionStr;
@synthesize carousel,wrap;



CATransform3D rotationTransform1[PHOTONUM];
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController.navigationBar setHidden:YES];
    wrap = NO;
    carousel.delegate = self;
    carousel.dataSource = self;
    
    carousel.type = iCarouselTypeCoverFlow;
    [carousel reloadData];
    
    
    
//    self.view.backgroundColor = [UIColor clearColor];
//	UIImageView *backview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"121.png"]];
//	//backview.frame = self.view.frame;
//	backview.center = CGPointMake(backview.center.x, backview.center.y - 10);
//	
//	backview.alpha = 0.3;
//	[self.view addSubview:backview];
//	
//    NSArray *textArray = [NSArray arrayWithObjects:@"Home",@"Shop",@"System",@"展厅四",@"展厅五",nil];
//    
//	float centery = self.view.center.y - 100;
//	float centerx = self.view.center.x;
//    
//	for (int i = 0;i<PHOTONUM;i++ ) 
//	{
//		float tmpy =  centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
//		float tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
//		myimgeview *addview1 =	[[myimgeview alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d",PHOTOSTRING,i+1]] text:[textArray objectAtIndex:i]];
//        addview1.frame = CGRectMake(0.0, 0.0,250,290);
//		[addview1 setdege:self];
//		addview1.tag = TAGSTART + i;
//		addview1.center = CGPointMake(tmpx,tmpy);
//		rotationTransform1[i] = CATransform3DIdentity;	
//		
//		//float Scalenumber =atan2f(sin(2.0*M_PI *i/PHOTONUM));
//		float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
//		if (Scalenumber<0.6) 
//		{
//			Scalenumber = 0.6;
//		}
//		CATransform3D rotationTransform = CATransform3DIdentity;
//		rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);		
//		addview1.layer.transform=rotationTransform;		
//		[self.view addSubview:addview1];
//		[addview1 release];
//	}
//	currenttag = TAGSTART;
    
    [self initGenieView];
    
  //  [self initRoomTableData];
}

-(void) initGenieView
{
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
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.m_shengjiAlertView) {
        self.m_shengjiAlertView = [[UIAlertView alloc] initWithTitle:@"Upgrade Tips" message:@"Being upgraded product information, please do not quit\r\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        UIActivityIndicatorView* actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        CGRect rect = [actView frame];
        rect.origin = CGPointMake(130, 108);
        actView.frame = rect;
        [self.m_shengjiAlertView addSubview:actView];
        
        [actView startAnimating];
        
        
        
        [actView release];
    }

    
    [self requestVersionTable];
    
   // [self performSelector:@selector(initGenieView) withObject:nil afterDelay:0.05];
}

- (void)viewDidUnload
{
    [self setM_infoView:nil];
    [self setM_infoButton:nil];
    [self setM_tishiImageView:nil];
    [self setColseInforView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    
    return NO;
}

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


-(void)Clickup:(NSInteger)tag
{
    //  kIsAdShow;
	NSLog(@"点击TAG%d:",tag);
    //	int = currenttag - tag;
	if(currenttag == tag)
	{
        AppDelegate* delegate = [[UIApplication sharedApplication] delegate];

        switch (currenttag-TAGSTART) {
            case 0:
            {
                RoomTableObj* obj = [DataBase GetSingleRoomTableObj];
                obj.m_hallId = [[NSString alloc] initWithString:@"A"];
                [delegate entryHallOne];
            }
                break;
            case 1:
                
            {
                RoomTableObj* obj = [DataBase GetSingleRoomTableObj];
                obj.m_hallId = [[NSString alloc] initWithString:@"B"];
                [delegate entryHallTwo];
            }

                break;
            case 2:
            {
                RoomTableObj* obj = [DataBase GetSingleRoomTableObj];
                obj.m_hallId = [[NSString alloc] initWithString:@"C"];
                [delegate entryHallThree];
            }
               
                break;
                
            default:
                break;
        }
        return ;
        
		UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"点击" message: @"添加自己的处理" delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
		av.tag=110;
		[av show];
		[av release];	
		return;
	}
	int t = [self getblank:tag];
	//NSLog(@"%d",t);
	int i = 0;
	for (i = 0;i<PHOTONUM;i++ ) 
	{
		
		UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];
		[imgview.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
		[imgview.layer addAnimation:[self setscale:TAGSTART+i clicktag:tag] forKey:@"transform"];
		
		int j = array[tag - TAGSTART][i];
		float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.6) 
		{
			Scalenumber = 0.6;
		}
		CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
		//imgview.layer.transform=dtmp;
		
        //	imgview.layer.needsDisplayOnBoundsChange = YES;
	}
	currenttag = tag;
    //	[self performSelector:@selector(setcurrenttag) withObject:nil afterDelay:TIME];
}


-(void)setcurrenttag
{
	int i = 0;
	for (i = 0;i<PHOTONUM;i++ ) 
	{
		
		UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];		
		int j = array[currenttag - TAGSTART][i];
		float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.6) 
		{
			Scalenumber = 0.6;
		}
		CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
		imgview.layer.transform=dtmp;
		
		//	imgview.layer.needsDisplayOnBoundsChange = YES;
	}
}


-(CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag
{
	
	
	int i = array[clicktag - TAGSTART][tag - TAGSTART];
	int i1 = array[currenttag - TAGSTART][tag - TAGSTART];
	float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
	float Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
	if (Scalenumber<0.6) 
	{
		Scalenumber = 0.6;
	}

	CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.duration = TIME;
	animation.repeatCount =1;
	
	
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
	animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
	animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
	animation.autoreverses = NO;	
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	//imgview.layer.transform=dtmp;
	
	return animation;
}


-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num
{
	// CALayer
	UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];	
	CGMutablePathRef path = CGPathCreateMutable();
	NSLog(@"原点%f原点%f",imgview.layer.position.x,imgview.layer.position.y);
	CGPathMoveToPoint(path, NULL,imgview.layer.position.x,imgview.layer.position.y);
	
	int p =  [self getblank:tag];
	NSLog(@"旋转%d",p);
	float f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
	float h = f + 2.0*M_PI *num/PHOTONUM;
	float centery = self.view.center.y - 100;
	float centerx = self.view.center.x;
	float tmpy =  centery + RADIUS*cos(h);
	float tmpx =	centerx - RADIUS*sin(h);
	imgview.center = CGPointMake(tmpx,tmpy);
	
	CGPathAddArc(path,nil,self.view.center.x, self.view.center.y - 100,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);	
	animation.path = path;
	CGPathRelease(path);
	animation.duration = TIME;
	animation.repeatCount = 1;
 	animation.calculationMode = @"paced"; 	
	return animation;
}

- (IBAction)infoButton:(id)sender 
{
    if (!self.isShow){
        self.isShow = YES;
        //[NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(geineAnimationDone) userInfo:nil repeats:NO];
    }else {
        return;
    }
    
    [self.m_infoButton setEnabled:NO];
    [self.genieView genieAnimationShow:self.isShow withDuration:1];
}

- (IBAction)shengjiButton:(id)sender 
{
    
    bool haveNet = [DataProcess IsConnectedToNetwork];
    
    if (!haveNet) {
        NSLog(@"没有网络！！");
        [self performSelectorOnMainThread:@selector(callUpgradeNoNetOnMainThread) withObject:nil waitUntilDone:NO];
        return;
    }
    
    
    
    [self.m_shengjiAlertView show];
    m_bCancleDown = false;
    m_bHaveError = NO;
    
    [self requestProductTable];
    [self requestImageTable];
    [self requestPosTable];
    [self requestTypeTable];
    [self startDownImageAndWriteToDatabase];
    
    //[self requestVersionTable];
    
    [self.m_tishiImageView setHidden:YES];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}



-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (m_shengjiAlertView == alertView) {
        if (buttonIndex) {
            
            m_bCancleDown = true;
            NSLog(@"cancle");
        }
    }else{
        
        
    }
    

}


-(NSInteger)getblank:(NSInteger)tag
{
	if (currenttag>tag) 
	{
		return currenttag - tag;
	}
	else 
	{
		return PHOTONUM  - tag + currenttag;
	}
    
}

-(void)Scale
{
	[UIView beginAnimations:nil context:self];
	[UIView setAnimationRepeatCount:3];
    [UIView setAnimationDuration:1];	
	
	/*
	 + (void)setAnimationWillStartSelector:(SEL)selector;                // default = NULL. -animationWillStart:(NSString *)animationID context:(void *)context
	 + (void)setAnimationDidStopSelector:(SEL)selector;                  // default = NULL. -animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
	 + (void)setAnimationDuration:(NSTimeInterval)duration;              // default = 0.2
	 + (void)setAnimationDelay:(NSTimeInterval)delay;                    // default = 0.0
	 + (void)setAnimationStartDate:(NSDate *)startDate;                  // default = now ([NSDate date])
	 + (void)setAnimationCurve:(UIViewAnimationCurve)curve;              // default = UIViewAnimationCurveEaseInOut
	 + (void)setAnimationRepeatCount:(float)repeatCount;                 // default = 0.0.  May be fractional
	 + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;
	 */
	
	CATransform3D rotationTransform = CATransform3DIdentity;
    
    rotationTransform = CATransform3DRotate(rotationTransform,3.14, 1.0, 0.0, 0.0);	
	//rotationTransform = CATransform3DScale (rotationTransform, 0.1,0.1, 2);
    //self.view.transform=CGAffineTransformMakeScale(2,2);
	
	self.view.layer.transform=rotationTransform;
    [UIView setAnimationDelegate:self];	
    [UIView commitAnimations];
}






- (IBAction)hallOneButton:(id)sender {
    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate entryHallOne];
    
    
}

- (IBAction)hallTwoButton:(id)sender {
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate entryHallTwo];
}

- (IBAction)hallThreeButton:(id)sender {
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate entryHallThree];
}
- (void)dealloc {
    [m_infoView release];
    [m_infoButton release];
    [m_shengjiAlertView release];
    [m_downImageArr release];
    [m_downPosArr release];
    [m_downProductArr release];
    [m_downVersionStr release];
    
    [m_tishiImageView release];
    [colseInforView release];
    [super dealloc];
}


-(void) initRoomTableData
{
    [DataBase createDB];
    RoomTableObj* roomobj = [[RoomTableObj alloc] init];
    for (int i=0; i<11; i++) {
        
        roomobj.m_roomId = [NSString stringWithFormat:@"A%d",i];
        roomobj.m_roomName = [NSString stringWithFormat:@"A%d",i];
        roomobj.m_hallId = @"A";
        
        [DataBase addRoomTableObj:roomobj];
        
    }
    for (int i=0; i<9; i++) {
        
        roomobj.m_roomId = [NSString stringWithFormat:@"B%d",i];
        roomobj.m_roomName = [NSString stringWithFormat:@"B%d",i];
        roomobj.m_hallId = @"B";
        
        [DataBase addRoomTableObj:roomobj];
        
    }
    for (int i=0; i<10; i++) {
        
        roomobj.m_roomId = [NSString stringWithFormat:@"C%d",i];
        roomobj.m_roomName = [NSString stringWithFormat:@"C%d",i];
        roomobj.m_hallId = @"C";
        
        [DataBase addRoomTableObj:roomobj];
        
    }
    
    RoomTableObj* temObj = [DataBase getOneRoomTableInfo:@"C6"];

        NSLog(@"[DataBase getAllRoomTableObj] : roomid = %@,hallImge = %@,bulbid = %@",temObj.m_roomId,temObj.m_hallId,temObj.m_roomName);

    
}

-(void) requestImageTable
{
    m_bImageDownFlag = NO;
    NSString* str = @"<?xml version='1.0' encoding='utf-8' ?>\
    <command>\
    <commandid>image</commandid>\
    <requestimage>\
    <imageid>45456=2;2=3;5=1</imageid>\
    </requestimage>\
    </command>";
    
    NSArray* temArr = [DataBase getAllImageTableObj];
    str = [MyXMLParser EncodeToStr:temArr Type:@"image"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];

    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByImageTable:)];
    [http threadFunStart];
    
    [http release];
}

-(void) receiveDataByImageTable:(NSData*) data
{
    if (self.m_downImageArr) {
        [self.m_downImageArr release];
        self.m_downImageArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"stem_downImageArr := %@",str);
        self.m_downImageArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (self.m_downImageArr) {
            NSLog(@"接收到 数据：m_downImageArr 解析 成功"); 

            for (int i=0; i<self.m_downImageArr.count; i++) {
                ImageTableObj* proobj = [self.m_downImageArr objectAtIndex:i];
                NSLog(@"proid = %@ flag = %d",proobj.m_imageId,proobj.m_flag);
            }
        }else{
            NSLog(@"接收到 数据：m_downImageArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByImageTable 接收到 数据 异常");
        m_bHaveError = YES;

    }
    m_bImageDownFlag = YES;

}

//升级请求
-(void) requestPosTable
{
    m_bPosDownFlag = NO;
    NSString* str = @"<?xml version='1.0' encoding='utf-8' ?>\
    <command>\
    <commandid>pos</commandid>\
    <requestpos>\
    <posid>6=1;5=3</posid>\
    </requestpos>\
    </command>";
    NSArray* temArr = [DataBase getAllPosTableObj];
    str = [MyXMLParser EncodeToStr:temArr Type:@"pos"];
    
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByPosTable:)];
    [http threadFunStart];
    
    [http release];
}
-(void) receiveDataByPosTable:(NSData*) data
{
    if (self.m_downPosArr) {
        [self.m_downPosArr release];
        self.m_downPosArr = nil;
    }

    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"getm_downPosArr str : %@",str);
        self.m_downPosArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (self.m_downPosArr) {
            NSLog(@"接收到 数据：m_downPosArr 解析 成功"); 
            for (int i=0; i<self.m_downPosArr.count; i++) {
                PosTableObj* proobj = [self.m_downPosArr objectAtIndex:i];
                NSLog(@"proid = %@ flag = %d",proobj.m_posId,proobj.m_flag);
            }

        }else{
             NSLog(@"接收到 数据：m_downPosArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByPosTable 接收到 数据 异常");
        m_bHaveError = YES;
    }
    m_bPosDownFlag = YES;
}

//升级请求
-(void) requestTypeTable
{
    m_bTypeDownFlag = NO;
    NSString* str = @"<?xml version='1.0' encoding='utf-8' ?>\
    <command>\
    <commandid>prolist</commandid>\
    <requestpos>\
    <posid>6=1;5=3</posid>\
    </requestpos>\
    </command>";
    NSArray* temArr = [DataBase getAllTypeTableObj];
    str = [MyXMLParser EncodeToStr:temArr Type:@"prolist"];
    
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByTypeTable:)];
    [http threadFunStart];
    
    [http release];

}
-(void) receiveDataByTypeTable:(NSData*) data
{
    if (self.m_downTypeArr) {
        [self.m_downTypeArr release];
        self.m_downTypeArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downTypeArr str : %@",str);
        self.m_downTypeArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (self.m_downTypeArr) {
            NSLog(@"接收到 数据：m_downTypeArr 解析 成功"); 
            for (int i=0; i<self.m_downTypeArr.count; i++) {
                TypeTableObj* proobj = [self.m_downTypeArr objectAtIndex:i];
                NSLog(@"typeid = %@ flag = %d",proobj.m_typeId,proobj.m_flag);
            }
            
        }else{
            NSLog(@"接收到 数据：m_downTypeArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByPosTable 接收到 数据 异常");
        m_bHaveError = YES;
    }
    m_bTypeDownFlag = YES;
}

//升级请求
-(void) requestProductTable
{
    m_bProductDownFlag = NO;
    NSString* str = @"<?xml version='1.0' encoding='utf-8' ?>\
    <command>\
    <commandid>product</commandid>\
    <requestproduct>\
    <proid>270=0;456456=8;48489=0</proid>\
    </requestproduct>\
    </command>";
    
    NSArray* temArr = [DataBase getAllBulbTableObj];
    str = [MyXMLParser EncodeToStr:temArr Type:@"product"];
    
    NSLog(@"encode = %@",str);
    
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByProductTable:)];
    [http threadFunStart];
    
    [http release];
}
-(void) receiveDataByProductTable:(NSData*) data
{
    if (self.m_downProductArr) {
        [self.m_downProductArr release];
        self.m_downProductArr = nil;
    }
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"get str : %@",str);

        self.m_downProductArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (self.m_downProductArr) {
            NSLog(@"接收到 数据：m_downProductArr 解析 成功"); 
            for (int i=0; i<self.m_downProductArr.count; i++) {
                ProductTableObj* proobj = [self.m_downProductArr objectAtIndex:i];
                NSLog(@"proid = %@ flag = %d",proobj.m_bulbId,proobj.m_flag);
            }
            
        }else{
            NSLog(@"接收到 数据：m_downProductArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByProductTable 接收到 数据 异常");
        m_bHaveError = YES;
    }
    m_bProductDownFlag = YES;
}

//升级请求
-(void) requestVersionTable
{
    m_bVersionDownFlag = NO;
    NSString* str = @"<?xml version='1.0' encoding='utf-8' ?>\
    <command>\
    <commandid>version</commandid>\
    <requestver>\
    <version>0</version>\
    </requestver>\
    </command>";
    
    NSString* temArr = [DataBase getAllVersionTableObj];
    str = [MyXMLParser EncodeToStr:temArr Type:@"version"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"version = %@",str);
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByVersionTable:)];
    [http threadFunStart];
    
    [http release];
}

//显示还是 隐藏提示View
-(void) hideOrShowTishiImageView:(NSString*) str
{
    if (0 == [str compare:[DataBase getAllVersionTableObj]]) {
        [self.m_tishiImageView setHidden:YES];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }else {
        [self.m_tishiImageView setHidden:NO];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    }
}

-(void) receiveDataByVersionTable:(NSData*) data
{       
    if (self.m_downVersionStr) {
        [self.m_downVersionStr release];
        self.m_downVersionStr = nil;
    }
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        self.m_downVersionStr = [[NSString alloc] initWithString:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (self.m_downVersionStr) {

            NSLog(@"接收到 数据：m_downVersionStr 解析 成功"); 
            NSLog(@"version str = %@",self.m_downVersionStr);
        }else{
            NSLog(@"接收到 数据：m_downVersionStr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByVersionTable 接收到 数据 异常");
        m_bHaveError = YES;
    }
    m_bVersionDownFlag = YES;
    
    [self performSelectorOnMainThread:@selector(hideOrShowTishiImageView:) withObject:self.m_downVersionStr waitUntilDone:NO];
    
}

//开启一个 单独线程 下载图片和 写数据库
-(void) startDownImageAndWriteToDatabase
{
    if (!m_bCancleDown) {
        //初始化 写数据库 都未 no
        m_bImageWriteDataBaseFlag = NO;
        m_bPosWriteDataBaseFlag = NO;
        m_bProductWriteDataBaseFlag = NO;
        m_bVersionWriteDataBaseFlag = NO;
        m_bTypeWriteDataBaseFlag = NO;
        
        [NSThread detachNewThreadSelector:@selector(threadDownWriteFun) toTarget:self withObject:nil];
    }
    
}

-(void) threadDownWriteFun
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    bool haveNet = YES;
    while (!m_bCancleDown) {

        haveNet = [DataProcess IsConnectedToNetwork];
        if (!haveNet) {
            m_bHaveError = true;
            break;
        }
        if (m_bImageDownFlag) {
            
            if ( self.m_downImageArr && self.m_downImageArr.count>0) {
                
                for (int i=0; i<self.m_downImageArr.count && !m_bCancleDown; i++) {
                    
                    ImageTableObj* imageobj = [self.m_downImageArr objectAtIndex:i];
                    switch (imageobj.m_flag) {
                        case 1:
                        {
                            BOOL suc = [DataProcess downAndWriteImgeforUrl:imageobj.m_imageUrl];
                            if (suc) {
                                suc = [DataBase addImageTableObj:imageobj];
                                if (!suc) {
                                    NSLog(@"suc = [DataBase addImageTableObj:imageobj]; 失败!!");
                                    m_bHaveError = true;
                                }
                                
                            }else{
                                NSLog(@"suc = [DataProcess downAndWriteImgeforUrl:imageobj.m_imageUrl]; 失败!!");
                                m_bHaveError = true;
                            }
                            continue;
                        }
                            break;
                        case 0:
                        {
                            BOOL suc = [DataProcess downAndWriteImgeforUrl:imageobj.m_imageUrl];
                            if (suc) {
                                suc = [DataBase alterImageTableObj: imageobj];
                                if (!suc) {
                                    NSLog(@"suc = case 0:alterImageTableObj: imageobj; 失败!!");
                                    m_bHaveError = true;
                                }
                                
                            }else{
                                NSLog(@"suc = case 0:[DataProcess downAndWriteImgeforUrl:imageobj.m_imageUrl]; 失败!!");
                                m_bHaveError = true;
                            }
                            continue;
                        }

                            break;
                        case -1:
                        {
                            BOOL suc = [DataBase deleteImageTableObj:imageobj];
                            if (!suc) {
                                NSLog(@"BOOL suc = [DataBase deleteImageTableObj:imageobj]; 失败!!");
                                m_bHaveError = true;
                            }
                            continue;
                        }

                            break;
                        default:
                            break;
                    }
                    
                    
                }
                
            }
           
            m_bImageDownFlag = NO;
            m_bImageWriteDataBaseFlag = YES; 
            
        }else if(m_bPosDownFlag) {
            
            if ( self.m_downPosArr && self.m_downPosArr.count>0) {
                
                for (int i=0; i<self.m_downPosArr.count && !m_bCancleDown; i++) {
                    
                    PosTableObj* posobj = [self.m_downPosArr objectAtIndex:i];
                    switch (posobj.m_flag) {
                        case 1:
                        {

                            bool suc = [DataBase addPosTableObj: posobj];
                            if (!suc) {
                                NSLog(@"bool suc = [DataBase addPosTableObj: posobj]; 失败!!");
                                m_bHaveError = true;
                            }

                            continue;
                        }
                            break;
                        case 0:
                        {
                            bool suc = [DataBase alterPosTableObj: posobj];
                            if (!suc) {
                                NSLog(@"bool suc = [DataBase alterPosTableObj: posobj]; 失败!!");
                                m_bHaveError = true;
                            }
                            continue;                        
                        }
                            
                            break;
                        case -1:
                        {
                            BOOL suc = [DataBase deletePosTableObj:posobj];
                            if (!suc) {
                                NSLog(@"BOOL suc = [DataBase deletePosTableObj:posobj]; 失败!!");
                                m_bHaveError = true;
                            }
                            continue;
                        }
                            
                            break;
                        default:
                            break;
                    }
                    
                    
                }
                
            }
            
            m_bPosDownFlag = NO;
            m_bPosWriteDataBaseFlag = YES; 
            
        }else if(m_bProductDownFlag) {
            
            if ( self.m_downProductArr && self.m_downProductArr.count>0) {
                
                for (int i=0; i<self.m_downProductArr.count && !m_bCancleDown; i++) {
                    
                    ProductTableObj* proobj = [self.m_downProductArr objectAtIndex:i];
                    switch (proobj.m_flag) {
                        case 1:
                        {
                            BOOL suc = [DataProcess downAndWriteImgeforUrl:proobj.m_bulbImage];
                            if (suc) {
                                suc = [DataBase addProductTableObj:proobj];
                                if (!suc) {
                                    NSLog(@"suc = [DataBase addProductTableObj:proobj]; 失败!!");
                                    m_bHaveError = true;
                                }
                                
                            }else{
                                NSLog(@"sBOOL suc = [DataProcess downAndWriteImgeforUrl:proobj.m_bulbImage]; 失败!!");
                                m_bHaveError = true;
                            }
                            continue;
                        }
                            break;
                        case 0:
                        {
                            BOOL suc = [DataProcess downAndWriteImgeforUrl:proobj.m_bulbImage];
                            if (suc) {
                                suc = [DataBase alterProductTableObj:proobj];
                                if (!suc) {
                                    NSLog(@"suc = [DataBase alterProductTableObj:proobj]; 失败!!");
                                    m_bHaveError = true;
                                }
                                
                            }else{
                                NSLog(@"s BOOL suc = [DataProcess downAndWriteImgeforUrl:proobj.m_bulbImage]; fd失败!!");
                                m_bHaveError = true;
                            }
                            continue;
                        }
                            
                            break;
                        case -1:
                        {
                            BOOL suc = [DataBase deleteProductTableObj:proobj];
                            if (!suc) {
                                NSLog(@"BOOL suc =  [DataBase deleteProductTableObj:proobj]; 失败!!");
                                m_bHaveError = true;
                            }
                            continue;
                        }
                            
                            break;
                        default:
                            break;
                    }
                    
                    
                }
                
            }
            
            m_bProductDownFlag = NO;
            m_bProductWriteDataBaseFlag = YES; 
        }else if(m_bTypeDownFlag) {
            
            if ( self.m_downTypeArr && self.m_downTypeArr.count>0) {
                
                for (int i=0; i<self.m_downTypeArr.count && !m_bCancleDown; i++) {
                    
                    TypeTableObj* posobj = [self.m_downTypeArr objectAtIndex:i];
                    switch (posobj.m_flag) {
                        case 1:
                        {
                            
                            bool suc = [DataBase addTypeTableObj: posobj];
                            if (!suc) {
                                NSLog(@"bool suc = [DataBase addTypeTableObj: posobj] 失败!!");
                                m_bHaveError = true;
                            }
                            
                            continue;
                        }
                            break;
                        case 0:
                        {
                            bool suc = [DataBase alterTypeTableObj: posobj];
                            if (!suc) {
                                NSLog(@"bool suc = [DataBase alterTypeTableObj: posobj]; 失败!!");
                                m_bHaveError = true;
                            }
                            continue;                        
                        }
                            
                            break;
                        case -1:
                        {
                            BOOL suc = [DataBase deleteTypeTableObj:posobj];
                            if (!suc) {
                                NSLog(@"BOOL suc = [DataBase deleteTypeTableObj:posobj]; 失败!!");
                                m_bHaveError = true;
                            }
                            continue;
                        }
                            
                            break;
                        default:
                            break;
                    }
                    
                    
                }
                
            }
            
            m_bTypeDownFlag = NO;
            m_bTypeWriteDataBaseFlag = YES; 
            
        }
        
            
        if (m_bImageWriteDataBaseFlag && m_bProductWriteDataBaseFlag && m_bPosWriteDataBaseFlag && m_bTypeWriteDataBaseFlag) {
            
            if (m_bHaveError) {
                NSLog(@"写入数据库 或 下载 图片 文件，出现异常。版本升级未成功！！");
            }else{
                
                NSLog(@"down version str = %@",self.m_downVersionStr);
                bool suc = [DataBase addVersionTableObj:self.m_downVersionStr];
                if (suc) {
                    m_bHaveError = NO;
                    NSLog(@"写入数据库 或 下载 图片 文件  版本升级成功！！");
                }else{
                    m_bHaveError = YES;
                    NSLog(@"写bool suc = [DataBase addVersionTableObj:self.m_downVersionStr]; 未成功！！");
                }
            }
            [self.m_shengjiAlertView dismissWithClickedButtonIndex:2 animated:YES];
            if(!m_bHaveError)
                [self performSelectorOnMainThread:@selector(callUpgradeSuccOnMainThread) withObject:nil waitUntilDone:NO];
            else
                [self performSelectorOnMainThread:@selector(callUpgradeFailureOnMainThread) withObject:nil waitUntilDone:NO];
            break;
            
        }
        
    }
    
    if (!haveNet) {
        [self.m_shengjiAlertView dismissWithClickedButtonIndex:2 animated:YES];
        [self performSelectorOnMainThread:@selector(callUpgradeNoNetOnMainThread) withObject:nil waitUntilDone:NO];
    }
    
    
    [pool release];
}

-(void) callUpgradeSuccOnMainThread
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade Tips" message:@"Product information upgrade success." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
    [DataProcess copyDatabaseSqliteFileToDownImage];
}
-(void) callUpgradeFailureOnMainThread
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade Tips" message:@"Upgrade fails, upgrade again to ensure access to the latest information." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

-(void) callUpgradeNoNetOnMainThread
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade Tips" message:@"No network upgrade failed.Please connect to the network." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}


- (IBAction)closeInfoView:(id)sender 
{
    self.isShow = NO;
    self.m_infoView.hidden = YES;
    [self.genieView genieAnimationShow:self.isShow withDuration:1];
}


#pragma mark -

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    UIView *view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d",PHOTOSTRING,(index%5)+1]]] autorelease];
    
    view.frame = CGRectMake(70, 80, 598, 380);
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 3;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return wrap;
}


//- (BOOL)carousel:(iCarousel *)carousel shouldSelectItemAtIndex:(NSInteger)index
//{
//    NSLog(@"select index = %d",index);
//    return YES;
//}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"didSelectItemAtIndex index = %d",index);
    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    
    switch (index) {
        case 0:
        {
            //            RoomTableObj* obj = [DataBase GetSingleRoomTableObj];
            //            obj.m_hallId = [[NSString alloc] initWithString:@"D"];
            [delegate entryHallOne];
        }
            break;
        case 1:
            
        {
            [delegate entryHallTwo];
        }
            
            break;
        case 2:
        {
            [delegate entryHallThree];
        }
            
            break;
        case 3:
        {
            [delegate entryHallFour];
        }
            
            break;
            
        default:
            break;
    }
    return ;
    
}


@end

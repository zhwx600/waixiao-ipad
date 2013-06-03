//
//  DetailParamViewController.m
//  LiDaXin-iPad
//
//  Created by apple on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailParamViewController.h"
#import "AppDelegate.h"

@interface DetailParamViewController ()

@end

@implementation DetailParamViewController
@synthesize close;

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
}

- (void)viewDidUnload
{
    [self setClose:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.navigationItem.title = @"详细参数";
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    
    return NO;
}

- (IBAction)otherButton:(id)sender {
    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate entryOther];
}
- (void)dealloc {
    [close release];
    [super dealloc];
}
- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

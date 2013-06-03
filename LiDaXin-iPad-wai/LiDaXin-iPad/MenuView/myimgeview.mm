//
//  myimgeview.m
//  UIA
//
//  Created by sk on 11-7-28.
//  Copyright 2011 sk. All rights reserved.
//

#import "myimgeview.h"
#import"ViewController.h"

@implementation myimgeview

- (id)initWithImage:(UIImage *)image text:(NSString *)text
{
    self = [super init];
    if (self) 
    {
        UIImageView *imagview= [[UIImageView alloc]initWithImage:image];
        imagview.frame = CGRectMake(0,0,250,250);
        [self addSubview:imagview];
        [imagview release];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0,250,250,40)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:35];
        label.text = text;
        label.textColor = [UIColor blackColor];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
        [label release];
    }
    return self;
}

-(void)setdege:(id)ID
{
	self.userInteractionEnabled = YES;
	dege = ID;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	ViewController *tmp = (ViewController *)dege;
	[tmp Clickup:self.tag];
}
@end

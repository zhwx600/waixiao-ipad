//
//  xmlparser.cpp
//  TinyXml
//
//  Created by user on 11-7-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#include "xmlparser.h"
#include "tinyxml.h"
#import "RoomTableObj.h"
#import "ImageTableObj.h"
#import "PosTableObj.h"
#import "ProductTableObj.h"
#import "TypeTableObj.h"

NSCondition             *_mutexEn = NULL;
NSCondition             *_mutexDe = NULL;



void xmlparser::Encode(S_Data *sData,string &xml)
{
	TTiXmlDocument doc; 
    if(!_mutexEn)
    {
       _mutexEn = [[NSCondition alloc] init];
    }
    [_mutexEn lock];
	TTiXmlDeclaration *decl = new TTiXmlDeclaration("1.0", "utf-8", ""); 
	doc.LinkEndChild( decl );
    
	TTiXmlElement *lmtRoot = new TTiXmlElement("command"); 
	doc.LinkEndChild(lmtRoot);
//    
//	TTiXmlElement *lmtId = new TTiXmlElement("id");
//	lmtRoot->LinkEndChild(lmtId);
//    if(sData->commandId.length() <= 0)
//    {
//        printf("sData->commandId.length() <= 0\n");
//        [_mutexEn unlock];
//        return;
//    }
//	TTiXmlText *txtId = new TTiXmlText(sData->commandId.c_str());
//	lmtId->LinkEndChild(txtId);
    
	TTiXmlElement *lmtName = new TTiXmlElement("name");
	lmtRoot->LinkEndChild(lmtName);
    if(sData->commandName.length() <= 0)
    {
        printf("sData->commandName.length() <= 0\n");
        [_mutexEn unlock];
        return;
    }
	TTiXmlText *txtName = new TTiXmlText(sData->commandName.c_str());
	lmtName->LinkEndChild(txtName);
//    
//	TTiXmlElement *lmtType = new TTiXmlElement("type");
//	lmtRoot->LinkEndChild(lmtType);
//    if(sData->type.length() <= 0)
//    {
//        printf("sData->type.length() <= 0\n");
//        [_mutexEn unlock];
//        return;
//    }    
//	TTiXmlText *txtType = new TTiXmlText(sData->type.c_str());
//	lmtType->LinkEndChild(txtType);
    
	TTiXmlElement *lmtParamRoot = new TTiXmlElement("params");
	lmtRoot->LinkEndChild(lmtParamRoot);
    
    map<string, string>::iterator iter;
    for(iter = sData->params.begin(); iter != sData->params.end(); iter++)
    {
		TTiXmlElement *lmtTmp = new TTiXmlElement("param");
		lmtParamRoot->LinkEndChild(lmtTmp);
        
		TTiXmlElement *lmtKey = new TTiXmlElement("key");
		lmtTmp->LinkEndChild(lmtKey);
		TTiXmlText *txtKey = new TTiXmlText(iter->first.c_str());
		lmtKey->LinkEndChild(txtKey);
        
		TTiXmlElement *lmtValue = new TTiXmlElement("value");
		lmtTmp->LinkEndChild(lmtValue);
		TTiXmlText *txtValue = new TTiXmlText(iter->second.c_str());
        
		lmtValue->LinkEndChild(txtValue);     
	}
	TiXmlPrinter printer;
    printer.SetStreamPrinting();
	doc.Accept(&printer);
    
	xml.assign(printer.CStr());
    [_mutexEn unlock];
    //	xml.a("%s",printer.CStr());
}

bool xmlparser::Decode(const char *xml,S_Data *sData)
{
	TTiXmlDocument doc;
    if(!_mutexDe)
    {
        _mutexDe = [[NSCondition alloc] init];
    }    
    [_mutexDe lock];
	if(doc.Parse(xml)==0)
	{
        printf("TTiXmlDocument parser error\n");
        [_mutexDe unlock];
		return false;
	}

	TTiXmlElement *lmtRoot = doc.RootElement();
	if(!lmtRoot)
    {
        [_mutexDe unlock];
		return false;
    }
	TTiXmlElement *lmtName = lmtRoot->FirstChildElement("name");
	if (lmtName)
	{
//		const char *id = lmtId->GetText();
//        //		sData->commandId = atoi(id);
//        sData->commandId.assign(id);
        
        const char *name = lmtName->GetText();
        sData->commandName.assign(name);

//		TTiXmlElement *lmtName = lmtId->NextSiblingElement("name");
//		if (lmtName)
//		{
//			const char *name = lmtName->GetText();
//			sData->commandName.assign(name);
//		}
        
//        
//		TTiXmlElement *lmtType = lmtName->NextSiblingElement("type");
//		if (lmtType)
//		{
//			const char *type = lmtType->GetText();
//			sData->type.assign(type);
//		}
        
		TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("params");
		if (lmtParamRoot)
		{
            string strKey;
            string strValue;
			TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
			while (lmtTmp)
			{
				TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("key");
				if (lmtKey)
				{
					TTiXmlElement *lmtValue = lmtKey->NextSiblingElement("value");
					if (lmtValue)
					{
						strKey.assign(lmtKey->GetText());
                        
						strValue.assign(lmtValue->GetText());
						strValue = strValue=="(null)"?"":strValue;
                        
                        sData->params[strKey]=strValue;
						//sData->params.insert(pair<string, string>(strKey,strValue));
                        
                        //NSLog(@"key=%s,value=%s",strKey.c_str(),strValue.c_str());
					}
				}
                
				lmtTmp = lmtTmp->NextSiblingElement();
//                printf("%s++++\n",sData->params.at(strKey).c_str());
//                NSLog(@"%s----size=%d",sData->params.at(strKey).c_str(),sData->params.size());
//                NSLog(@"%s****size=%d",sData->params[strKey.c_str()].c_str(),sData->params.size());
			}
		}
	}
    [_mutexDe unlock];
	return true;
}


@implementation MyXMLParser

+(NSString*) EncodeToStr:(NSObject *)obj Type:(NSString *)type
{
    TTiXmlDocument doc; 
    if(!_mutexEn)
    {
        _mutexEn = [[NSCondition alloc] init];
    }
    [_mutexEn lock];
	TTiXmlDeclaration *decl = new TTiXmlDeclaration("1.0", "utf-8", ""); 
	doc.LinkEndChild( decl );
    
	TTiXmlElement *lmtRoot = new TTiXmlElement("command"); 
	doc.LinkEndChild(lmtRoot);
    
    TTiXmlElement *lmtName = new TTiXmlElement("commandid");
    lmtRoot->LinkEndChild(lmtName);
    if(type.length <= 0)
    {
        printf("type <= 0\n");
        [_mutexEn unlock];
        return nil;
    }
    TTiXmlText *txtId = new TTiXmlText([type UTF8String]);
    lmtName->LinkEndChild(txtId);
    
    //版本表
    if (0 == [type compare:@"version"]) {
        
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestver");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("version");
        lmtParamRoot->LinkEndChild(lmtTmp);
        NSString*  strin = nil;
        if (!obj || ([(NSString*)obj length] <= 0)) {
            strin = @"0";
        }else{
            strin = (NSString*)obj;
        }
        
        TTiXmlText *txtId = new TTiXmlText([strin UTF8String]);
        lmtTmp->LinkEndChild(txtId);
    //产品表
    }else if(0 == [type compare:@"product"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestproduct");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("proid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            ProductTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_bulbId,proobj.m_bulbVersionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];
        //图片表
    }else if(0 == [type compare:@"image"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestimage");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("imageid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }

        for (int i=0; i<temArr.count; i++) {
            
            ImageTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_imageId,proobj.m_bulbVersionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];
        //图片表
    }else if(0 == [type compare:@"pos"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestpos");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("posid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }

        for (int i=0; i<temArr.count; i++) {
            
            PosTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_posId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];
    }else if(0 == [type compare:@"prolist"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestprolist");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("prolistid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            TypeTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_typeId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];
    }

    
    
    
   	TiXmlPrinter printer;
    printer.SetStreamPrinting();
	doc.Accept(&printer);

    NSString* returnstr = [[[NSString alloc] initWithCString:printer.CStr() encoding:NSUTF8StringEncoding] autorelease];
    
    [_mutexEn unlock];

    return returnstr;
}

+(NSObject*) DecodeToObj:(NSString *)str
{
    TTiXmlDocument doc;
    if(!_mutexDe)
    {
        _mutexDe = [[NSCondition alloc] init];
    }    
    [_mutexDe lock];
	if(doc.Parse([str UTF8String])==0)
	{
        printf("TTiXmlDocument parser error\n");
        [_mutexDe unlock];
		return nil;
	}
    
	TTiXmlElement *lmtRoot = doc.RootElement();
	if(!lmtRoot)
    {
        [_mutexDe unlock];
		return nil;
    }
	TTiXmlElement *lmtName = lmtRoot->FirstChildElement("commandid");
	if (lmtName)
	{
        const char *name = lmtName->GetText();
        NSString* commid = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        if (0 == [commid compare:@"version"]) {
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("requestver");
            TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
            NSString* ver = [[[NSString alloc] initWithCString:lmtTmp->GetText() encoding:NSUTF8StringEncoding] autorelease];
            [_mutexDe unlock];
            return ver;
            
            
        }else if(0 == [commid compare:@"image"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {

                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ImageTableObj* imageObj = [[ImageTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("imageid");
                    imageObj.m_imageId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imageurl");
                    imageObj.m_imageUrl = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("roomid");
                    imageObj.m_roomId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("description");
                    imageObj.m_description = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_bulbVersionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 1;
                    
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ImageTableObj* imageObj = [[ImageTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("imageid");
                    imageObj.m_imageId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imageurl");
                    imageObj.m_imageUrl = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("roomid");
                    imageObj.m_roomId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("description");
                    imageObj.m_description = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_bulbVersionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = 0;
                    
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                    while (lmtTmp)
                    {
                        TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("imageid");
                        ImageTableObj* imageObj = [[ImageTableObj alloc] init];
                        
                        imageObj.m_imageId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                        imageObj.m_flag = -1;
                        [imageArr addObject:imageObj];
                        [imageObj release];

                        //进入下一个 param
                        lmtTmp = lmtTmp->NextSiblingElement();
                        
                    }
                
            }

            [_mutexDe unlock];
            return imageArr;
            
                       
        }else if(0 == [commid compare:@"product"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ProductTableObj* imageObj = [[ProductTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("proid");
                    imageObj.m_bulbId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("protype");
                    imageObj.m_bulbType = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("proparam");
                    imageObj.m_bulbParam = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("prourl");
                    imageObj.m_bulbImage = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_bulbVersionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = 1;
                    
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ProductTableObj* imageObj = [[ProductTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("proid");
                    imageObj.m_bulbId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("protype");
                    imageObj.m_bulbType = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("proparam");
                    imageObj.m_bulbParam = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("prourl");
                    imageObj.m_bulbImage = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_bulbVersionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = 0;
                    
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("proid");
                    ProductTableObj* imageObj = [[ProductTableObj alloc] init];
                    
                    imageObj.m_bulbId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
            [_mutexDe unlock];
            return imageArr;

            
        }else if(0 == [commid compare:@"pos"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    PosTableObj* imageObj = [[PosTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("posid");
                    imageObj.m_posId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("posx");
                    imageObj.m_posX = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("posy");
                    imageObj.m_posY = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("proid");
                    imageObj.m_bulbId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imageid");
                    imageObj.m_imageId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = 1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    PosTableObj* imageObj = [[PosTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("posid");
                    imageObj.m_posId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("posx");
                    imageObj.m_posX = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("posy");
                    imageObj.m_posY = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("proid");
                    imageObj.m_bulbId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imageid");
                    imageObj.m_imageId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = 0;
                    
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("posid");
                    PosTableObj* imageObj = [[PosTableObj alloc] init];
                    
                    imageObj.m_posId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
                        
            [_mutexDe unlock];
            return imageArr;
        }else if(0 == [commid compare:@"prolist"]){
            {
                
                NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
                
                TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
                
                if (lmtParamRoot)
                {
                    
                    TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                    while (lmtTmp)
                    {
                        TypeTableObj* imageObj = [[TypeTableObj alloc] init];
                        TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("prolistid");
                        imageObj.m_typeId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                        
                        lmtKey = lmtKey->NextSiblingElement("pointid");
                        imageObj.m_posId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                        
                        lmtKey = lmtKey->NextSiblingElement("productid");
                        imageObj.m_bulbId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];

                        lmtKey = lmtKey->NextSiblingElement("ver");
                        imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                        imageObj.m_flag = 1;
                        [imageArr addObject:imageObj];
                        [imageObj release];
                        //进入下一个 param
                        lmtTmp = lmtTmp->NextSiblingElement();
                        
                    }
                }
                
                lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
                
                if (lmtParamRoot)
                {
                    
                    TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                    while (lmtTmp)
                    {
                        TypeTableObj* imageObj = [[TypeTableObj alloc] init];
                        TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("prolistid");
                        imageObj.m_typeId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                        
                        lmtKey = lmtKey->NextSiblingElement("pointid");
                        imageObj.m_posId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                        
                        lmtKey = lmtKey->NextSiblingElement("productid");
                        imageObj.m_bulbId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                        
                        lmtKey = lmtKey->NextSiblingElement("ver");
                        imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                        imageObj.m_flag = 1;
                        [imageArr addObject:imageObj];
                        [imageObj release];
                        //进入下一个 param
                        lmtTmp = lmtTmp->NextSiblingElement();                        
                    }
                }
                
                lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
                
                if (lmtParamRoot)
                {
                    
                    TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                    while (lmtTmp)
                    {
                        TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("prolistid");
                        TypeTableObj* imageObj = [[TypeTableObj alloc] init];
                        
                        imageObj.m_typeId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                        imageObj.m_flag = -1;
                        [imageArr addObject:imageObj];
                        [imageObj release];
                        
                        //进入下一个 param
                        lmtTmp = lmtTmp->NextSiblingElement();
                        
                    }
                    
                }
                
                
                [_mutexDe unlock];
                return imageArr;
            }
        }
    }
    
    [_mutexDe unlock];
    return  nil;
}

@end











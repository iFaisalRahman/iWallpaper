//
//  DataLoad.m
//  iWallpaper
//
//  Created by Mohammad Faisal Rahman on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataLoad.h"
#import "AsynchronousParser.h"

@implementation DataLoad

@synthesize delegate,callback,callbackfailed;

-(void)getDataFromURL:(NSString*)URL  Data:(NSDictionary*)data{


	filterName = [[[NSString alloc] initWithFormat:@"%@",[data objectForKey:@"FilterName"]] autorelease];
	isFilter = (int) [[data objectForKey:@"Filter"] intValue];
	isRandom = (int)[[data objectForKey:@"Randomness"] intValue];
	/*
	if( [[data objectForKey:@"Filter"] isEqualToString:@"YES"]  )
		isFilter   = 1;
	else {
		isFilter   = 0;
	}

	if( [[data objectForKey:@"Randomness"] isEqualToString:@"YES"]  )
		isRandom   = 1;
	else {
		isRandom   = 0;
	}
	*/
	NSString *urlData = [[[NSString alloc] initWithFormat:@"Filter=%d&FilterName=%@&Randomness=%d",isFilter, filterName, isRandom] autorelease];
	NSLog(@"%@", urlData);
//	AsynchronousParser *parser = [[AsynchronousParser alloc] initWithUrl:URL Data:urlData];
	AsynchronousParser *parser = [[AsynchronousParser alloc] initWithCallBack:self :@selector(ParserDidRecieveData:) :@selector(ParserDataRequestFailedWithParser:)];
	[parser initWithUrl:URL Data:urlData];
	
}

-(DataLoad*)initDataLoadWithCallBack:(id)requestDelegate :(SEL)requestSelector :(SEL)requestFailed{


	self.delegate=requestDelegate;
	self.callback=requestSelector;
	self.callbackfailed=requestFailed;
	return self;
}



-(void)ParserDidRecieveData:(NSArray*)arr {
	
	[delegate performSelector:callback withObject: arr];
	
}
-(void)ParserDataRequestFailedWithParser{
	NSLog(@"Parser Failed");
	[delegate performSelector:callbackfailed ];
}


@end

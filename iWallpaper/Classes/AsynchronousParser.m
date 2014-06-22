//
//  test.m
//  AsynchronousJson2
//
//  Created by system on 2/20/10.
//  Copyright 2010 rise uP!. All rights reserved.
//

#import "AsynchronousParser.h"
#import "JSON.h"

//#define SERVER @"lklklklk";


@implementation AsynchronousParser

@synthesize delegate,callback,connection,callbackfailed;


-(void)CancelConnection{
	[connection cancel];
}

-(void)jsonParser:(NSString *)URL Data:(NSString*)data{
	

	
 	data=[data stringByAddingPercentEscapesUsingEncoding:1];
	
	NSString *post =[NSString stringWithFormat:@"%@",data];
	
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:URL]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)jsonReturn:(NSMutableData*)data{
	
	
	SBJSON *jParser = [[[SBJSON alloc]init]autorelease];
	NSString *json_string = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]autorelease];

	NSArray *arr = [jParser objectWithString:json_string error:nil];

	[delegate performSelector:callback withObject:arr ];
	
}

-(AsynchronousParser*)initWithUrl:(NSString *)URL Data:(NSString*)data{

	[self jsonParser:URL Data:data];
	
	return self;
}


-(AsynchronousParser*)initWithCallBack:(id)requestDelegate :(SEL)requestSelector :(SEL)requestFailed{

	self.delegate=requestDelegate;
	self.callback=requestSelector;
	self.callbackfailed=requestFailed;
	return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	
	//NSLog(@"response recieve");
	
	if(recieveData==nil)
	{
		recieveData = [[NSMutableData alloc]init];
	}
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	
	[recieveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
	
	[self jsonReturn:recieveData];

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
/*
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Ooops! No Internet!" message:@"We couldn't load the wallpapers. Please check your network connection settings or try again later. Wifi or Edge/3G service is required for wallpapers to work properly." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
 */
	
	[delegate performSelector:callbackfailed withObject: self];
}
- (void)dealloc {
	
	[connection cancel];
	[connection release];
	[recieveData release];
	[delegate release];

    [super dealloc];

	NSLog(@"Deallaocating: AsynchronousParser...");
}

@end

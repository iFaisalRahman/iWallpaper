//
//  AsynchronousParser.h
//  AsynchronousJson2
//
//  Created by system on 2/20/10.
//  Copyright 2010 rise uP!. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AsynchronousParser : NSObject {

	NSURLConnection *connection;
	NSMutableData   *recieveData;
	
	id					delegate;
	SEL					callback;
	SEL					callbackfailed;
}

@property(nonatomic, retain) id			    delegate;
@property(nonatomic) SEL					callback;
@property(nonatomic) SEL					callbackfailed;
@property(nonatomic,retain) NSURLConnection *connection;

-(AsynchronousParser*)initWithUrl:(NSString *)URL Data:(NSString*)data;

-(AsynchronousParser*)initWithCallBack:(id)requestDelegate :(SEL)requestSelector :(SEL)requestFailed;

-(void)CancelConnection;

@end

//
//  AsyncImageView.h
//  Postcard
//
//  Created by markj on 2/18/09.
//  Copyright 2009 Mark Johnson. You have permission to copy parts of this code into your own projects for any use.
//  www.markj.net
//

#import <UIKit/UIKit.h>


@interface AsyncImageView : UIView {

	UIActivityIndicatorView *indicator;
	NSURLConnection* connection;
	NSMutableData* data;
	
	
	id					delegate;
	SEL					callback;
	SEL					touchCallback;
}

@property(nonatomic, retain) id			delegate;
@property(nonatomic) SEL					callback;
@property(nonatomic) SEL					touchCallback;

@property(nonatomic,retain)NSURLConnection *connection;


-(void)initWithCallBack:(id)requestDelegate :(SEL)requestSelector :(SEL)requestSelector2;
- (void)loadImageFromURL:(NSURL*)url;

@end
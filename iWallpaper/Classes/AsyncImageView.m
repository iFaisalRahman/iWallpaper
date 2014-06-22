//
//  AsyncImageView.m
//  Postcard
//
//  Created by markj on 2/18/09.
//  Copyright 2009 Mark Johnson. You have permission to copy parts of this code into your own projects for any use.
//  www.markj.net
//





#import "AsyncImageView.h"

extern int numOfDownloadedImage;


@implementation AsyncImageView

@synthesize delegate,callback,touchCallback,connection;



-(void)initWithCallBack:(id)requestDelegate :(SEL)requestSelector :(SEL)requestSelector2{

	self.delegate=requestDelegate;
	self.callback=requestSelector;
	self.touchCallback =requestSelector2;
	
}




- (void)loadImageFromURL:(NSURL*)url {
	
	
	UIImageView* imageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];	
	
	//imageView.image=[UIImage imageNamed:@"f1.png"];
	
	imageView.animationImages = [NSArray arrayWithObjects:   
									[UIImage imageNamed:@"f1.png"],
									[UIImage imageNamed:@"f2.png"],
									[UIImage imageNamed:@"f3.png"],
									[UIImage imageNamed:@"f4.png"],
									[UIImage imageNamed:@"f5.png"],
									[UIImage imageNamed:@"f6.png"],
									[UIImage imageNamed:@"f7.png"],
									[UIImage imageNamed:@"f8.png"],
									[UIImage imageNamed:@"f9.png"],
									[UIImage imageNamed:@"f10.png"],
									[UIImage imageNamed:@"f11.png"], nil];
	
	// all frames will execute in 1.75 seconds
	imageView.animationDuration = 1.2;
	// repeat the annimation forever
	imageView.animationRepeatCount = 0;
	// start animating
	[imageView startAnimating];
	
	
	//imageView.contentMode = UIViewContentModeScaleToFill;
	[self addSubview:imageView];
	//imageView.frame = self.bounds;
	[imageView setNeedsLayout];
	[self setNeedsLayout];
	
	
	if (connection!=nil) { [connection release]; } //in case we are downloading a 2nd image
	if (data!=nil) { [data release]; }
	
	
	NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; //notice how delegate set to self object

	if(!connection)
	{
		NSLog(@"no connection");
	
	}
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

	NSLog(@"%d",self.tag); //isImageView added as subview
	
	NSString *str = [[[NSString alloc]initWithFormat:@"%d",self.tag]autorelease];
	if( [self.subviews count])
	{
		[delegate performSelector:touchCallback withObject: str];
	}
}



//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	


	if (data==nil) { data = [[NSMutableData alloc] init]; } 
	[data appendData:incrementalData];
}

//the URL connection calls this once all the data has downloaded
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	
	while ([self.subviews count] >  0)
	{
		[ [self.subviews objectAtIndex:0] removeFromSuperview];
	}
	
	UIImageView* imageView;
	UIImage *myImage = [[[UIImage alloc]initWithData:data]autorelease];

	if(myImage!=nil)
	{
		imageView = [[[UIImageView alloc] initWithImage:myImage] autorelease];
	}
	else
	{
		imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"download_error_small.png"]] autorelease];	
		self.userInteractionEnabled=NO;
	}
	

	imageView.contentMode = UIViewContentModeScaleToFill;
	[self addSubview:imageView];
	imageView.frame = self.bounds;
	[imageView setNeedsLayout];
	[self setNeedsLayout];

	
	numOfDownloadedImage++;
	
	if(numOfDownloadedImage==9)
	{
			[delegate performSelector:callback];
	}
	
	self.alpha = 0;
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.5];
	
	self.alpha =1;
	
	[UIView commitAnimations];
	
	
	[connection release];
	connection=nil;
	[data release]; //don't need this any more, its in the UIImageView now
	data=nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	
	NSLog(@"connection failed");
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ooops! No Internet!" message:@"We couldn't load the wallpapers. Please check your network connection settings or try again later. Wifi or Edge/3G service is required for wallpapers to work properly." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];

	UIImageView* imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"download_error_small.png"]] autorelease];	
	self.userInteractionEnabled=NO;
	imageView.contentMode = UIViewContentModeScaleToFill;
	[self addSubview:imageView];
	imageView.frame = self.bounds;
	[imageView setNeedsLayout];
	[self setNeedsLayout];
	
	numOfDownloadedImage++;
	if(numOfDownloadedImage==9)
	{
		[delegate performSelector:callback];
	}
}
- (void)dealloc {
	
	
	[connection cancel]; //in case the URL is still downloading
	[connection release];
	[data release];
	[delegate release];
	
    [super dealloc];
	
}
@end
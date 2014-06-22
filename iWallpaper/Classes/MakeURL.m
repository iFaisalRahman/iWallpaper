//
//  MakeURL.m
//  iWallpaper
//
//  Created by Mohammad Faisal Rahman on 5/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MakeURL.h"


#define SERVER_PATH @"http://173.230.157.86/WallpaperCollection"

@implementation MakeURL


-(NSArray*)makeURLFromData:(NSArray*)URLArr Search:(BOOL)isSearch{

	NSMutableArray *arr = [[[NSMutableArray alloc] init] autorelease];
	
	NSString *ImageURL;
	NSString *folderName;
	NSString *imageName;
	
	if(isSearch == NO)
	{
		for (NSDictionary *imageInfo in URLArr ) 
		{
			
			
			folderName=[imageInfo objectForKey:@"CategoryName"];
			imageName=[imageInfo objectForKey:@"ImageName"];
			ImageURL=[[[NSString alloc] initWithFormat:@"%@/%@/smallImages/%@.jpg",SERVER_PATH,folderName,imageName] autorelease];
			
			
			
			
			ImageURL=[ImageURL stringByAddingPercentEscapesUsingEncoding:1];
			[arr addObject:ImageURL];
			
		}
	}
	else
	{
		NSDictionary *Dic = [(NSDictionary*)URLArr objectForKey:@"photos"];
		
		NSArray *photos = [Dic objectForKey:@"photo"];
		if([photos count]==0)
		{
			UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"No Image Found!!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		
		for (NSDictionary *photo in photos)
		{
			NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
			[arr  addObject:photoURLString];
			
		} 
		
		
		NSLog(@"%@", Dic);
	
	}
	NSLog(@"%@",arr);
	return arr;
	
}

-(void)dealloc{

	NSLog(@"Dealloacating...");
}
@end

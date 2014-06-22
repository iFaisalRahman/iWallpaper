//
//  DataLoad.h
//  iWallpaper
//
//  Created by Mohammad Faisal Rahman on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataLoad : NSObject {

	NSArray *array;
	int isFilter;
	int isRandom;
	NSString *filterName;

	
	id					delegate;
	SEL					callback;
	SEL					callbackfailed;
}
@property(nonatomic, retain) id			    delegate;
@property(nonatomic) SEL					callback;
@property(nonatomic) SEL					callbackfailed;


-(void)getDataFromURL:(NSString*)URL  Data:(NSDictionary*)data;

-(DataLoad*)initDataLoadWithCallBack:(id)requestDelegate :(SEL)requestSelector :(SEL)requestFailed;


@end

//
//  Category.h
//  wallpaper
//
//  Created by Mohammad Faisal Rahman on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Category : UIViewController<UITableViewDelegate, UITableViewDataSource> {

	NSMutableArray *catArr;
	
	UITableView *catTable;
	id					delegate;
	SEL					callback;

}
@property(nonatomic, retain) id			    delegate;
@property(nonatomic) SEL					callback;





-(Category*)initCategoryWithCallBack:(id)requestDelegate :(SEL)requestSelector;

@end

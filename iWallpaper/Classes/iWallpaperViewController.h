//
//  iWallpaperViewController.h
//  iWallpaper
//
//  Created by Mohammad Faisal Rahman on 5/27/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum  {
	
	NoMove = 0,
	Back=1,
	Forward=2,
	
} ScrollingType;

@interface iWallpaperViewController : UIViewController<UISearchBarDelegate> {

	IBOutlet UIScrollView *myScrollView;
	
	UISegmentedControl *mySegment;
	
	UISearchBar *mySearchBar;
	
	IBOutlet UIView *loadingView;
	IBOutlet UILabel *loadingLabel;
	
	BOOL isSearchON;
	
	ScrollingType myscrollingType;
	
	
	
	//DATA HOLDER
	
	NSMutableArray *URLArray;
	NSMutableArray *URLArrayForSearch;
	
	NSDictionary *catInfo;
	
	NSString *filterName;
	BOOL isFilter;
	BOOL isRandom;
	
}
@property(nonatomic, retain)UIScrollView *myScrollView;
@property(nonatomic, retain)UIView *loadingView;
@property(nonatomic, retain)UILabel *loadingLabel;
@end


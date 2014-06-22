//
//  iWallpaperViewController.m
//  iWallpaper
//
//  Created by Mohammad Faisal Rahman on 5/27/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "iWallpaperViewController.h"
#import "AsyncImageView.h"
#import "DataLoad.h"
#import "MakeURL.h"
#import "Category.h"
#import <QuartzCore/QuartzCore.h>

#define WIDTH 105
#define HEIGHT 142
#define numOfImageDownloadInParallel 9
#define API_KEY @"f0af6f5d6426f2ec220e1f933d9da367" // flicker API_KEY

NSMutableArray *imageNames;
int pageToDownload = 0, numOfDownloadedImage = 0, totalImageDownloaded = 0, prevPageNum = 0, prevDownloadPageNum = 0;
BOOL isAllImageDownload = NO, downloadDirection=YES;


@implementation iWallpaperViewController
@synthesize myScrollView, loadingView, loadingLabel;


#pragma mark Image Updates, removes

-(void)updateImage:(int )pageNumber{
	
	
	int pos = pageNumber*320;
	int posY = 1;
	
	int imageIndex = pageNumber*9;
	
	AsyncImageView *imageView1;
	
	NSURL *url;
	
	for(int i =  1 ; i <= numOfImageDownloadInParallel ; i++)
	{
		
		if(imageIndex >= [imageNames count])
		{
			isAllImageDownload = YES;
			//NSLog(@"all image downloaded: %d  %d",imageIndex, [imageNames count]);
			break;
		}
		
		
		switch(i%9)
		{
				
			case 1:
				
				imageView1 = [[AsyncImageView alloc]initWithFrame:CGRectMake(pos, posY, WIDTH, HEIGHT)];
			
				url = [[NSURL alloc]initWithString:[imageNames objectAtIndex:imageIndex]];
				
				
				[imageView1 loadImageFromURL:url];
				
				[imageView1 initWithCallBack:self :@selector(reload) :@selector(switchToLargeImageViewController:)];
				
				imageView1.tag=imageIndex;
				
				[myScrollView addSubview:imageView1];
				
				[imageView1  release];
				
				[url release];
				
				break;
				
			case 2:
				
				imageView1 = [[AsyncImageView alloc]initWithFrame:CGRectMake(WIDTH+pos, posY, WIDTH, HEIGHT)];
				
				
				
				url = [[NSURL alloc]initWithString:[imageNames objectAtIndex:imageIndex]];
				
				
				[imageView1 initWithCallBack:self :@selector(reload) :@selector(switchToLargeImageViewController:)];
				
				[imageView1 loadImageFromURL:url];
				
				imageView1.tag=imageIndex;
				
				[myScrollView addSubview:imageView1];
				
				[imageView1  release];
				
				[url release];
				
				
				break;
				
			case 3:
				
				imageView1 = [[AsyncImageView alloc]initWithFrame:CGRectMake(WIDTH*2+pos, posY, WIDTH, HEIGHT)];
				
				
				
				
				
				[imageView1 initWithCallBack:self :@selector(reload) :@selector(switchToLargeImageViewController:)];
				
				url = [[NSURL alloc]initWithString:[imageNames objectAtIndex:imageIndex]];
				
				
				[imageView1 loadImageFromURL:url];
				
				imageView1.tag=imageIndex;
				
				[myScrollView addSubview:imageView1];
				
				[imageView1  release];
				
				[url release];
				
				
				break;
				

			case 4:
				
				imageView1 = [[AsyncImageView alloc]initWithFrame:CGRectMake(pos, HEIGHT+posY, WIDTH, HEIGHT)];
				
				url = [[NSURL alloc]initWithString:[imageNames objectAtIndex:imageIndex]];
				
				
				[imageView1 loadImageFromURL:url];
				
				[imageView1 initWithCallBack:self :@selector(reload) :@selector(switchToLargeImageViewController:)];
				
				imageView1.tag=imageIndex;
				
				[myScrollView addSubview:imageView1];
				
				[imageView1  release];
				
				[url release];
				
				break;
			case 5:
				
				imageView1 = [[AsyncImageView alloc]initWithFrame:CGRectMake(WIDTH+pos, HEIGHT+posY, WIDTH, HEIGHT)];
				
				url = [[NSURL alloc]initWithString:[imageNames objectAtIndex:imageIndex]];
				
				
				[imageView1 loadImageFromURL:url];
				
				[imageView1 initWithCallBack:self :@selector(reload) :@selector(switchToLargeImageViewController:)];
				
				imageView1.tag=imageIndex;
				
				[myScrollView addSubview:imageView1];
				
				[imageView1  release];
				
				[url release];
				
				break;
			case 6:
				
				imageView1 = [[AsyncImageView alloc]initWithFrame:CGRectMake(WIDTH*2+pos, HEIGHT+posY, WIDTH, HEIGHT)];
				
				url = [[NSURL alloc]initWithString:[imageNames objectAtIndex:imageIndex]];
				
				
				[imageView1 loadImageFromURL:url];
				
				[imageView1 initWithCallBack:self :@selector(reload) :@selector(switchToLargeImageViewController:)];
				
				imageView1.tag=imageIndex;
				
				[myScrollView addSubview:imageView1];
				
				[imageView1  release];
				
				[url release];
				
				break;
			case 7:
				
				imageView1 = [[AsyncImageView alloc]initWithFrame:CGRectMake(pos, HEIGHT*2+posY, WIDTH, HEIGHT)];
				
				url = [[NSURL alloc]initWithString:[imageNames objectAtIndex:imageIndex]];
				
				
				[imageView1 loadImageFromURL:url];
				
				[imageView1 initWithCallBack:self :@selector(reload) :@selector(switchToLargeImageViewController:)];
				
				imageView1.tag=imageIndex;
				
				[myScrollView addSubview:imageView1];
				
				[imageView1  release];
				
				[url release];
				
				break;
			case 8:
				
				imageView1 = [[AsyncImageView alloc]initWithFrame:CGRectMake(WIDTH +pos, HEIGHT*2+posY, WIDTH, HEIGHT)];
				
				url = [[NSURL alloc]initWithString:[imageNames objectAtIndex:imageIndex]];
				
				
				[imageView1 loadImageFromURL:url];
				
				[imageView1 initWithCallBack:self :@selector(reload) :@selector(switchToLargeImageViewController:)];
				
				imageView1.tag=imageIndex;
				
				[myScrollView addSubview:imageView1];
				
				[imageView1  release];
				
				[url release];
				
				break;
				
			case 0:
				
				
				imageView1 = [[AsyncImageView alloc]initWithFrame:CGRectMake(WIDTH*2 +pos, HEIGHT*2+posY, WIDTH, HEIGHT)];
				
				
				
				
				
				
				[imageView1 initWithCallBack:self :@selector(reload) :@selector(switchToLargeImageViewController:)];
				
				url = [[NSURL alloc]initWithString:[imageNames objectAtIndex:imageIndex]];
				
				
				[imageView1 loadImageFromURL:url];
				
				imageView1.tag=imageIndex;
				
				[myScrollView addSubview:imageView1];
				
				[imageView1  release];
				
				[url release];
				
				break;
				
				
		}
	
		CALayer * l;
		
		
		l = [imageView1 layer];
		[l setMasksToBounds:YES];
		[l setCornerRadius:10.0];
		
		// You can even add a border
		[l setBorderWidth:2.0];
		[l setBorderColor:[[UIColor blackColor] CGColor]];
		
		
		
		imageIndex++;
		
		if(i%9==0)
		{
			pos=pos+320;
		}
	}
}

-(void)reload{
	
	numOfDownloadedImage = 0;
	
	if(totalImageDownloaded<135)
	{
		[self updateImage:pageToDownload];
		
		if(downloadDirection==YES)
		{
			pageToDownload++;
			
			myScrollView.contentSize=CGSizeMake(320*pageToDownload, 396);
			
		}
		else
		{
			pageToDownload--;
		}
		
		totalImageDownloaded+=9;
		
	}
	else
	{
		if(downloadDirection==YES)
		{
			myScrollView.contentSize=CGSizeMake(320*(pageToDownload+1), 396);
		}
	}
}

-(void)reset{
	
	isAllImageDownload=NO;
	prevDownloadPageNum=0;
	numOfDownloadedImage=0;
	totalImageDownloaded=0;
	pageToDownload=0;
	downloadDirection=YES;
	
	[myScrollView setContentOffset:CGPointMake(0,0) animated:NO];
	
	for(AsyncImageView *view in [myScrollView subviews])
	{
		if( [view class] == NSClassFromString(@"AsyncImageView") )
		{
			[view.connection cancel];
			[view removeFromSuperview];
		}
		else
		{
			[view removeFromSuperview];
		}
	}
}

-(void)removeImages:(NSString*)pageNumber_ {
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	
	int pageNumber = [pageNumber_ intValue];
	
	int tempImageIndex = pageNumber*4;
	
	
	for(AsyncImageView *view in [myScrollView subviews])
	{
		if( [view class] == NSClassFromString(@"AsyncImageView") )
		{
			if( view.tag>= tempImageIndex && view.tag< tempImageIndex+60  )
			{
				[view.connection cancel];
				[view removeFromSuperview];
			}
		}
		
	}
	
	[pool release];
}

- (void)segmentClicked:(id)sender{

	int index = mySegment.selectedSegmentIndex;
	
	switch (index)
	{
	
			case 0:
			
			isRandom = NO;
			[self getCategoryData];
			break;

			case 1:
			isRandom = YES;
			[self getCategoryData];
				break;

	}		
}


-(void)categoryButtonClicked{
	
	Category *myCategory = [[Category alloc] initWithNibName:@"Category" bundle:nil];

	[myCategory initCategoryWithCallBack:self :@selector( categorySelected:)];
	[self.navigationController pushViewController:myCategory animated:YES];
	
	
}

-(void)getCategoryData{

	
	NSString *str1, *str2;
	
	str1 = [[NSString alloc] initWithFormat:@"%d", isFilter];
	str2 = [[NSString alloc] initWithFormat:@"%d", isRandom];
	
	
	
	NSDictionary *data = [[[NSDictionary alloc] initWithObjectsAndKeys: filterName ,@"FilterName", str1,@"Filter", str2 ,@"Randomness", nil] autorelease];
	NSLog(@"%@", data);
	[self getDataLoadFromURL:@"http://173.230.157.86/WallpaperCollection/DataLoad.php" Data:data];
	
	
}

-(void)categorySelected:(NSDictionary*)subCateInfo{

	//catInfo = subCateInfo;
	filterName = [subCateInfo objectForKey:@"Name"];
	isFilter = YES;

	[self.navigationController popViewControllerAnimated:YES];
	
	[self getCategoryData];

	
}

-(void)switchToLargeImageViewController:(NSString*)str{

	NSLog(@"%@", str);
}

-(void)initData{

	filterName = @"All";
	isFilter = NO;
	isRandom = YES;
	
	isSearchON = NO;
	prevPageNum = 0;
	myscrollingType = 0;
	URLArray = [[NSMutableArray alloc] init];
	URLArrayForSearch = [[NSMutableArray alloc] init];
	
	loadingView.hidden=YES;
	[self.view sendSubviewToBack: loadingView];
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	[self initData];
	self.view.backgroundColor = [UIColor blackColor];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	self.navigationController.navigationBar.translucent=YES;
	//self.navigationController.navigationBar.tintColor = [UIColor clearColor];
	
	UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
	[[self navigationItem] setBackBarButtonItem: newBackButton];	
	[newBackButton release];
	
	UIBarButtonItem *searchButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchToolbar)]autorelease];
	UIBarButtonItem *categoryButton = [[[UIBarButtonItem alloc]initWithTitle:@"Filter" style:UIBarButtonSystemItemSave target:self action:@selector(categoryButtonClicked)]autorelease];
	self.navigationItem.rightBarButtonItem = searchButton;
	self.navigationItem.leftBarButtonItem  = categoryButton;

	
	
	
	// UISegment Controller	
	mySegment=[[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
	[ mySegment insertSegmentWithTitle:@"New"   atIndex:0 animated:YES];
	[ mySegment insertSegmentWithTitle:@"Random"  atIndex:1 animated:YES ];
	[ mySegment insertSegmentWithTitle:@"Favs"  atIndex:2 animated:YES ];
	
	mySegment.segmentedControlStyle=UISegmentedControlStyleBar;
	mySegment.tintColor=[UIColor purpleColor];
	[ mySegment addTarget:self action:@selector(segmentClicked:) forControlEvents:UIControlEventValueChanged];
	self.navigationItem.titleView = mySegment;
	
	myScrollView.frame = CGRectMake(0, 0, 320, 480);	
	
	

	
	
	// Search Bar
	
	mySearchBar = [[UISearchBar alloc] init];
	mySearchBar.frame = CGRectMake(0, 44, 320, 40);
	mySearchBar.barStyle=UIBarStyleBlackTranslucent;
	mySearchBar.translucent=YES;
	mySearchBar.delegate=self;
	mySearchBar.showsCancelButton=YES;
	mySearchBar.placeholder =@"Type a keyword to Search";
	
	
	/*
	NSDictionary *data = [[[NSDictionary alloc] initWithObjectsAndKeys: filterName,@"FilterName",isFilter,@"Filter",isRandom,@"Randomness", nil] autorelease];
	
	[self getDataLoadFromURL:@"http://173.230.157.86/WallpaperCollection/DataLoad.php" Data:data];
	*/
	mySegment.selectedSegmentIndex=1;

	
}


#pragma mark DataLoad

-(void)getDataLoadFromURL:(NSString*)URL Data:(NSDictionary*)data{

	DataLoad *dataLoad = [[[DataLoad alloc] init] autorelease];
	[dataLoad initDataLoadWithCallBack:self :@selector(dataLoadReceiveData:) :@selector(dataLoadRequestFailed) ];
	[dataLoad getDataFromURL:URL Data:data];
	
	loadingView.hidden=NO;
	[self.view bringSubviewToFront: loadingView];

}
-(void)dataLoadReceiveData:(NSArray*)arr{

	NSLog(@"%@", arr);
	
	
	loadingView.hidden=YES;
	[self.view sendSubviewToBack: loadingView];

	[self reset];
	
	MakeURL *myMakeURL = [[[MakeURL alloc] init] autorelease];
		
	NSArray *arrK =  [myMakeURL makeURLFromData:arr Search: isSearchON];
	
	
	[URLArray removeAllObjects];
	
	for (int i=0; i< [arrK count]; i++)
	{
			
		[URLArray addObject: [arrK objectAtIndex:i] ];
	}
	
	NSLog(@"%@", URLArray);
	
	
	
	imageNames = URLArray;
	
	[self reload];
}

-(void)dataLoadRequestFailed{

	

}

#pragma mark -
#pragma mark SearchBarDelegate
-(void)searchFromFlicker:(NSString*)searchText{

	
	searchText=[searchText stringByReplacingOccurrencesOfString:@" "withString:@"_"];

	NSString *url = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=200&sort=interestingness-desc&format=json&nojsoncallback=1", API_KEY,  searchText];
	
	[self getDataLoadFromURL:url Data:nil];
	
}

-(void)searchToolbar{
	[mySearchBar becomeFirstResponder];
	[self.view addSubview:mySearchBar];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

	isSearchON = YES;
	[searchBar removeFromSuperview];
	[self searchFromFlicker:searchBar.text];
	
	
	
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{

	[searchBar removeFromSuperview];


}


#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)newScrollView{
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView_ willDecelerate:(BOOL)decelerate{
	
	
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)newScrollView{
	
	
	int pX = newScrollView.contentOffset.x;
	
	int currentPageNum = pX/320; 
	
	NSLog(@"currentPageNum - %d",currentPageNum);
	//if(currentPageNum<0) currentPageNum=0;
	
	if( prevPageNum > currentPageNum )
	{
		NSLog(@" Scrolling to Back:%d",currentPageNum);
		prevPageNum = currentPageNum;
		myscrollingType = Back;
	}
	else
	{
		if( prevPageNum < currentPageNum )
		{
			NSLog(@" Scrolling to Forward:%d",currentPageNum);
			prevPageNum = currentPageNum;
			myscrollingType = Forward;
		}
		
		else 
		{
			NSLog(@" No Move:%d",currentPageNum);
			myscrollingType = NoMove;
		}
		
	}
	
	if(currentPageNum % 15 == 0 && currentPageNum >=15 && abs(currentPageNum-prevDownloadPageNum)==15  )
	{
		prevDownloadPageNum = currentPageNum;
		
		if(myscrollingType == Forward)
		{
			pageToDownload = currentPageNum;
			totalImageDownloaded=0;
			downloadDirection=YES;
			[self reload];
			[self performSelectorInBackground:@selector(removeImages:) withObject: [ [NSString alloc] initWithFormat:@"%d",currentPageNum-30 ]];
		}
		else
		{
			pageToDownload = currentPageNum-1;
			totalImageDownloaded=0;
			downloadDirection=NO;
			[self reload];
			[self performSelectorInBackground:@selector(removeImages:) withObject:[ [NSString alloc] initWithFormat:@"%d",currentPageNum+15 ]];
		}
	}
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)newScrollView{
	
	[self scrollViewDidEndScrollingAnimation:newScrollView];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[mySearchBar release];
    [super dealloc];
	

}

@end

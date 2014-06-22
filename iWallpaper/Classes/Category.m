//
//  Category.m
//  wallpaper
//
//  Created by Mohammad Faisal Rahman on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Category.h"
#import "DataLoad.h"
#define URL_CATEGORY @"http://173.230.157.86/WallpaperCollection/Rename.php"
@implementation Category
@synthesize delegate,callback;

-(void)getCategoryData{

	catArr = [[NSMutableArray alloc] init];
	[self getDataLoadFromURL: URL_CATEGORY Data:nil];
}

-(Category*)initCategoryWithCallBack:(id)requestDelegate :(SEL)requestSelector{
	self.delegate=requestDelegate;
	self.callback=requestSelector;
	return self;
	
}

- (void)viewDidLoad {
	
	catArr = [[NSMutableArray alloc] init];
	
    [super viewDidLoad];
	
	//[self catParser:@"data" url:@"http://173.230.157.86/WallpaperCollection/Rename.php"];

	[self getCategoryData];
	
	catTable = [[[UITableView alloc] initWithFrame: CGRectMake(0, 44, 320, 480-44) style:UITableViewStyleGrouped] autorelease];
	catTable.delegate=self;
	catTable.dataSource=self;
	[self.view addSubview:catTable];

}

#pragma mark DataLoad

-(void)getDataLoadFromURL:(NSString*)URL Data:(NSDictionary*)data{
	
	DataLoad *dataLoad = [[[DataLoad alloc] init] autorelease];
	[dataLoad initDataLoadWithCallBack:self :@selector(dataLoadReceiveData:) :@selector(dataLoadRequestFailed) ];
	[dataLoad getDataFromURL:URL Data:data];
	
	
}
-(void)dataLoadReceiveData:(NSArray*)arr{
	

	for(NSDictionary *dic in arr)
	{
		//dic2 = [[[NSDictionary alloc]  initWithObjectsAndKeys: [dic objectForKey:@"Cat"], @"Cat", [dic objectForKey:@"SubCat"], @"SubCat",nil ] autorelease];
		
		[catArr addObject:dic];
	}

	NSLog(@"%@", catArr);
	[catTable reloadData];
	
}
-(void)dataLoadRequestFailed{
	
	
	
	
}

#pragma mark Table Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	NSLog(@"%d", [catArr count]);
    return [catArr count];
}


- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
	NSLog(@"%@",[[catArr objectAtIndex:section] objectForKey:@"Cat"]);
	return  [[catArr objectAtIndex:section] objectForKey:@"Cat"] ;
}
 

- (NSInteger)tableView:(UITableView *)table
 numberOfRowsInSection:(NSInteger)section {
	
	NSArray *listData = [[catArr objectAtIndex:section] objectForKey:@"SubCat"];

	NSLog(@"%@",listData);
	return [listData count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
	NSArray *listData = [[catArr objectAtIndex:indexPath.section] objectForKey:@"SubCat"];
	
	UITableViewCell * cell = [tableView
							  dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
	
	if(cell == nil) {
		
		cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:SimpleTableIdentifier] autorelease];
		
		/*cell = [[[UITableViewCell alloc]
		 initWithStyle:UITableViewCellStyleSubtitle
		 reuseIdentifier:SimpleTableIdentifier] autorelease];
		 */
	}
	
	
	cell.textLabel.text = [[listData objectAtIndex:indexPath.row] objectForKey:@"Name"];
	//cell.accessoryType = UITableViewCellAccessoryCheckmark;
	return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	
	NSLog(@" select section %d && row %d", indexPath.section, indexPath.row);
	
	NSDictionary *dic = [[[catArr objectAtIndex:indexPath.section] objectForKey:@"SubCat"] objectAtIndex:indexPath.row];
	[delegate performSelector: callback withObject: dic];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

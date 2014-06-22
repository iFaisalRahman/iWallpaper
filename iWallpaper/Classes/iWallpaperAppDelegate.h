//
//  iWallpaperAppDelegate.h
//  iWallpaper
//
//  Created by Mohammad Faisal Rahman on 5/27/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iWallpaperViewController;

@interface iWallpaperAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iWallpaperViewController *viewController;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet iWallpaperViewController *viewController;
@end


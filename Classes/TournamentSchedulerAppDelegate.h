//
//  TournamentSchedulerAppDelegate.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TournamentSchedulerAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	UINavigationController*  standingsNavigationController;
	
	NSString *tempIdHolder;
	NSString *currentPage;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController*  standingsNavigationController;
@property (nonatomic, retain) NSString* tempIdHolder;
@property (nonatomic, retain) NSString* currentPage;

@end

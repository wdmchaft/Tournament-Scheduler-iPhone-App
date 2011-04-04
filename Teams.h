//
//  Teams.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TeamsViewController;

@interface Teams : NSObject {
	TeamsViewController *viewController;
	NSMutableData *responseData;
	NSURL *theURL;
}

-(void)queryServiceWithParent:(UIViewController *)controller;

@end

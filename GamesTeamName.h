//
//  GamesTeamName.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GamesDivisionViewController;

@interface GamesTeamName : NSObject {
	GamesDivisionViewController *viewController;
	NSMutableData *responseData;
	NSURL *theURL;
}

-(void)queryServiceWithParent:(UIViewController *)controller;

@end

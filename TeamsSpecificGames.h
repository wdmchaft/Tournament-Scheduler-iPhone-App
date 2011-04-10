//
//  TeamsSpecificGames.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TeamsSpecificGamesViewController;

@interface TeamsSpecificGames : NSObject {
	TeamsSpecificGamesViewController *viewController;
	NSMutableData *responseData;
	NSURL *theURL;
}

-(void)queryServiceWithParent:(UIViewController *)controller;

@end

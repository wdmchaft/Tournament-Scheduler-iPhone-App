//
//  Standings.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StandingsViewController;

@interface Standings : NSObject {
	StandingsViewController *viewController;
	NSMutableData *responseData;
	NSURL *theURL;
}

-(void)queryServiceWithParent:(UIViewController *)controller;

@end

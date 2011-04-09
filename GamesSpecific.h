//
//  GamesSpecific.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GamesSpecificViewController;

@interface GamesSpecific : NSObject {
	GamesSpecificViewController *viewController;
	NSMutableData *responseData;
	NSURL *theURL;
}

-(void)queryServiceWithParent:(UIViewController *)controller;

@end

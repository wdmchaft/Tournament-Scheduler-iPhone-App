//
//  StandingsDivision.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StandingsDivisionViewController;


@interface StandingsDivision : NSObject {
	StandingsDivisionViewController *viewController;
	NSMutableData *responseData;
	NSURL *theURL;
}

-(void)queryServiceWithParent:(UIViewController *)controller;

@end

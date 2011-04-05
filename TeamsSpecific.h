//
//  TeamsSpecific.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TeamsSpecificViewController;


@interface TeamsSpecific : NSObject {
	TeamsSpecificViewController *viewController;
	NSMutableData *responseData;
	NSURL *theURL;
}

-(void)queryServiceWithParent:(UIViewController *)controller;

@end

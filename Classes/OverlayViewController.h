//
//  OverlayViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TeamsDivisionViewController;

@interface OverlayViewController : UIViewController {
	
	TeamsDivisionViewController *rvController;
}

@property (nonatomic, retain) TeamsDivisionViewController *rvController;

@end
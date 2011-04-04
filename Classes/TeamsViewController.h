//
//  TeamsViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TeamsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *teamsView;
}

@property (nonatomic, retain) IBOutlet UITableView *teamsView;


@end

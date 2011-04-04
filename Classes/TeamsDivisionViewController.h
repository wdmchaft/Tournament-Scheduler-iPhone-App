//
//  TeamsDivisionViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TeamsDivisionViewController : UITableViewController {
	UITableView *teamsDivisionTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *teamsDivisionTableView;

@end

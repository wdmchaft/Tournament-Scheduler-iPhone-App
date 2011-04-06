//
//  GamesDivisionViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamesDivisionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *gamesDivisionTableView;
	
}

@property (nonatomic, retain) IBOutlet UITableView *gamesDivisionTableView;

@property (nonatomic, retain) NSMutableArray *gameIds;
@property (nonatomic, retain) NSMutableArray *gameHomeIds;
@property (nonatomic, retain) NSMutableArray *gameAwayIds;

@end

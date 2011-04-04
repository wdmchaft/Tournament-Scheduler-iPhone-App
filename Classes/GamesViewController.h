//
//  GamesViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GamesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *gamesTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *gamesTableView;

@property (nonatomic, retain) NSMutableArray *names;
@property (nonatomic, retain) NSMutableArray *ids;


@end

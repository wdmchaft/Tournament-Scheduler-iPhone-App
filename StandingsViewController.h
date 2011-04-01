//
//  StandingsViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *serviceView;
	
}

@property (nonatomic, retain) IBOutlet UITableView *serviceView;
@property (nonatomic, retain) NSMutableArray *names;
@property (nonatomic, retain) NSMutableArray *urls;

@end


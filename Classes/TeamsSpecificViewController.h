//
//  TeamsSpecificViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TeamsSpecificViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *teamTableView;
	UITableViewCell *teamRecordCell;
	
	
	NSArray *optionList;
}

@property (nonatomic, retain) IBOutlet UITableView *teamTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell *teamRecordCell;
@property (nonatomic, retain) NSArray *optionList;

@property (nonatomic, retain) NSString *teamName;
@property (nonatomic, retain) NSString *teamId;
@property (nonatomic, retain) NSString *teamWins;
@property (nonatomic, retain) NSString *teamLosses;
@property (nonatomic, retain) NSString *teamGoals;

@end

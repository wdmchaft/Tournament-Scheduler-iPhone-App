//
//  TeamsDivisionViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TeamsDivisionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *teamsDivisionTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *teamsDivisionTableView;

@property (nonatomic, retain) NSMutableArray *teamNames;
@property (nonatomic, retain) NSMutableArray *teamIds;


@end

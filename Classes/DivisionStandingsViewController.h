//
//  DivisionStandingsViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DivisionStandingsViewController : UIViewController {
	UITableView *serviceView;
}

// Create Arrays for Team Names, Points, Wins, Draws, and Losses
@property (nonatomic, retain) NSMutableArray *names;
@property (nonatomic, retain) NSMutableArray *pts;
@property (nonatomic, retain) NSMutableArray *wins;
@property (nonatomic, retain) NSMutableArray *draws;
@property (nonatomic, retain) NSMutableArray *losses;



@property (nonatomic, retain) IBOutlet UITableView *serviceView;

@property(nonatomic,retain)IBOutlet UITableViewCell *myCell;


@end

//
//  GamesSpecificViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GamesSpecificViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *gameTableView;
	UITableViewCell *gameDetailsCell;
	UITableViewCell *fieldDetailsCell;
}

@property (nonatomic, retain) IBOutlet UITableView *gameTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell *gameDetailsCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *fieldDetailsCell;

@property (nonatomic, retain) NSString *gameId;
@property (nonatomic, retain) NSString *awayId;
@property (nonatomic, retain) NSString *homeId;
@property (nonatomic, retain) NSString *awayMap;
@property (nonatomic, retain) NSString *homeMap;
@property (nonatomic, retain) NSString *awayScore;
@property (nonatomic, retain) NSString *homeScore;
@property (nonatomic, retain) NSString *round;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *status;

@property (nonatomic, retain) NSString *awayName;
@property (nonatomic, retain) NSString *homeName;
@property (nonatomic, retain) NSString *awayWins;
@property (nonatomic, retain) NSString *homeWins;
@property (nonatomic, retain) NSString *awayLosses;
@property (nonatomic, retain) NSString *homeLosses;

@end

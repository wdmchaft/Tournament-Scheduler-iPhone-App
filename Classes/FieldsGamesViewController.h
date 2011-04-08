//
//  FieldsGamesViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FieldsGamesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *gamesDivisionTableView;
	
}

@property (nonatomic, retain) IBOutlet UITableView *gamesDivisionTableView;

@property (nonatomic, retain) NSMutableArray *gameIds;
@property (nonatomic, retain) NSMutableArray *gameHomeIds;
@property (nonatomic, retain) NSMutableArray *gameAwayIds;
@property (nonatomic, retain) NSMutableArray *gameHomeMaps;
@property (nonatomic, retain) NSMutableArray *gameAwayMaps;
@property (nonatomic, retain) NSMutableArray *gameFields;
@property (nonatomic, retain) NSMutableArray *gameTimes;

@property (nonatomic, retain) NSMutableArray *gameHomeNames;
@property (nonatomic, retain) NSMutableArray *gameAwayNames;



@end

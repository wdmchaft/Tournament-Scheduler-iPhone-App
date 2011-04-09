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
	
}

@property (nonatomic, retain) IBOutlet UITableView *gameTableView;
@end

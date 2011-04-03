//
//  AboutViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *aboutTableView;
	UITableViewCell *aboutContentCell;
}

@property (nonatomic, retain) IBOutlet UITableView *aboutTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell *aboutContentCell;

@end

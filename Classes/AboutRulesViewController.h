//
//  AboutRulesViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutRulesViewController : UIViewController {
	UITableView *aboutRulesTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *aboutRulesTableView;

@end

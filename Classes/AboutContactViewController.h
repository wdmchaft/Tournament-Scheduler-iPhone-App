//
//  AboutContactViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutContactViewController : UIViewController {
	UITableView *aboutContactTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *aboutContactTableView;

@end

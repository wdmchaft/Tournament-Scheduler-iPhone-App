//
//  FieldsViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FieldsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *fieldsTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *fieldsTableView;

@property (nonatomic, retain) NSMutableArray *names;
@property (nonatomic, retain) NSMutableArray *ids;


@end
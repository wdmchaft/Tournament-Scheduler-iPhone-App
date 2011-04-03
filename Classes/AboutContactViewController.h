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
	
	
	NSArray *categoryList;
	NSArray *categoryCountList;
	NSArray *nameList;
	NSArray *imageList;
	
}


@property (nonatomic, retain) IBOutlet UITableView *aboutContactTableView;
@property (nonatomic, retain) NSArray *categoryList;
@property (nonatomic, retain) NSArray *categoryCountList;
@property (nonatomic, retain) NSArray *nameList;
@property (nonatomic, retain) NSArray *imageList;




@end

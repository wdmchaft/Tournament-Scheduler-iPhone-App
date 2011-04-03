//
//  AboutContactDetailViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutContactDetailViewController : UIViewController {
	UIView *headerView;
	
	UIImage *imageLarge;
	NSString *mainTitle;
	NSString *subTitle;
	NSString *mobile;
	NSString *email;
}

@property (nonatomic, retain) IBOutlet UIView *headerView;

@property (nonatomic, retain) UIImage *imageLarge;
@property (nonatomic, retain) NSString *mainTitle;
@property (nonatomic, retain) NSString *subTitle;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *email;


@end

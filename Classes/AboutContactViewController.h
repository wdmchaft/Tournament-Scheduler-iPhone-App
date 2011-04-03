//
//  AboutContactViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutContactViewController : UIViewController {

	
	
	NSArray *categoryList;
	NSArray *categoryCountList;
	NSArray *nameList;
	NSArray *imageList;
	
	
	
	// For the detailViewController
	NSArray *mobileList;
	NSArray *emailList;
	NSArray *titleList;
	NSArray *contactImages;
}


@property (nonatomic, retain) NSArray *categoryList;
@property (nonatomic, retain) NSArray *categoryCountList;
@property (nonatomic, retain) NSArray *nameList;
@property (nonatomic, retain) NSArray *imageList;

@property (nonatomic, retain) NSArray *mobileList;
@property (nonatomic, retain) NSArray *emailList;
@property (nonatomic, retain) NSArray *titleList;
@property (nonatomic, retain) NSArray *contactImages;




@end

//
//  GamesDivisionViewController.m
//  TournamentScheduler
//
//  Displays all games in a division
//
//  Created by Philip Dudley on 4/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GamesDivisionViewController.h"
#import "GamesDivisions.h"
#import "GamesSpecificViewController.h"
#import "TournamentSchedulerAppDelegate.h"

@implementation GamesDivisionViewController

@synthesize gamesDivisionTableView;

@synthesize gameIds;
@synthesize gameHomeIds;
@synthesize gameAwayIds;
@synthesize gameHomeMaps;
@synthesize gameAwayMaps;
@synthesize gameFields;
@synthesize gameTimes;

@synthesize gameHomeNames;
@synthesize gameAwayNames;



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	gameIds = [[NSMutableArray alloc] init];
	gameHomeIds = [[NSMutableArray alloc] init];
	gameAwayIds = [[NSMutableArray alloc] init];
	gameHomeMaps = [[NSMutableArray alloc] init];
	gameAwayMaps = [[NSMutableArray alloc] init];
	gameFields = [[NSMutableArray alloc] init];
	gameTimes = [[NSMutableArray alloc] init];
	
	gameHomeNames = [[NSMutableArray alloc] init];
	gameAwayNames = [[NSMutableArray alloc] init];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	GamesDivisions *gamesDivisions = [[GamesDivisions alloc] init];
	[gamesDivisions queryServiceWithParent:self];
	
	
		
		
	//GamesDivisions *gamesDivisions = [[GamesDivisions alloc] init];
//	[gamesDivisions queryServiceWithParent:self];
	
	

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	if (gameIds.count == 0) {
		return 1;
	}
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	if (gameIds.count == 0) {
		return 1;
	}
	else {
		NSLog(@"Number of Rows %d", gameIds.count);
		NSLog(@"Number of Rows/4 %d", (gameIds.count/4));
	}

	
    return (gameIds.count/4);
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (gameIds.count == 0) {
		return @"";
	}
	return [NSString stringWithFormat:@"Round %d", section+1];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}


	if (gameIds.count != 0) {
			
		int currentPosition = (indexPath.section * (gameIds.count/4)) + indexPath.row;
		NSLog(@"Homeid %@", [gameHomeIds objectAtIndex:currentPosition ]);
		NSLog(@"gameHomeNames %d", [gameHomeNames count]);
		NSLog(@"gameAwayNames %d", [gameAwayNames count]);
		if ([gameHomeIds objectAtIndex:currentPosition] == @"none" && [gameAwayIds objectAtIndex:currentPosition] == @"none")
			cell.textLabel.text = [NSString stringWithFormat:@"%@ vs %@", [gameHomeMaps objectAtIndex:currentPosition], [gameAwayMaps objectAtIndex:currentPosition]];
		else if([gameHomeIds objectAtIndex:currentPosition] == @"none")
			cell.textLabel.text = [NSString stringWithFormat:@"%@ vs %@", [gameHomeMaps objectAtIndex:currentPosition],[gameAwayNames objectAtIndex:currentPosition]];
		else if([gameAwayIds objectAtIndex:currentPosition] == @"none")
			cell.textLabel.text = [NSString stringWithFormat:@"%@ vs %@", [gameHomeNames objectAtIndex:currentPosition],[gameAwayMaps objectAtIndex:currentPosition]];
		else
			cell.textLabel.text = [NSString stringWithFormat:@"%@ vs %@", [gameHomeNames objectAtIndex:currentPosition],[gameAwayNames objectAtIndex:currentPosition]];

		[cell.textLabel setFont:[UIFont boldSystemFontOfSize:12]];
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'-07:00'-07:00'"];
		NSDate *date = [dateFormat dateFromString:[gameTimes objectAtIndex:currentPosition]];
		
		[dateFormat setDateFormat:@"hh:mm a"];
		
		//Optionally for time zone converstions
		// http://stackoverflow.com/questions/5684205/in-ios-is-daylight-saving-in-nstimezone-broken
		[dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
		
		NSString *stringFromDate = [dateFormat stringFromDate:date];
		
		NSLog(@"time before %@", [gameTimes objectAtIndex:indexPath.row]);
		
		// Convert date object to desired output format
		//[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
	//	dateStr = [dateFormat stringFromDate:date];  
	//	[dateFormat release];
		
		
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Game %@ - %@", [gameIds objectAtIndex:currentPosition], stringFromDate];
	}
	else {
		cell.textLabel.text = @"No Games";
	}

	return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (gameIds.count != 0) {
		
	
		int currentPosition = (indexPath.section * (gameIds.count/4)) + indexPath.row;
		if ([gameHomeIds objectAtIndex:currentPosition ] != @"none"){
		
		NSString *divId = [gameIds objectAtIndex:currentPosition];
		
		
		NSLog(@"ID %@", divId);
		
		//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:divName message:@"HELLO" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		//[alert show];
		//[alert autorelease];
		//	
		TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
		delegate.tempIdHolder= divId;
		//	delegate.currentPage = divName;
		//	//	
		//	//	
		//	//	
		
		GamesSpecificViewController *gamesSpecificView = [[GamesSpecificViewController alloc] init];
		
		gamesSpecificView.navigationItem.title = [NSString stringWithFormat:@"Game %@", divId];
		//self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil] autorelease];
		[self.navigationController pushViewController:gamesSpecificView animated:YES];
		[gamesSpecificView release];
		}
	
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	 [gamesDivisionTableView release];
	
	 [gameIds release];
	 [gameHomeIds release];
	 [gameAwayIds release];
	 [gameHomeMaps release];
	 [gameAwayMaps release];
	 [gameFields release];
	 [gameTimes release];
	
	 [gameHomeNames release];
	 [gameAwayNames release];
    [super dealloc];
}


@end


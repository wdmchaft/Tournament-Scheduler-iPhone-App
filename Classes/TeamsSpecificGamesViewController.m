//
//  TeamsSpecificGamesViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TeamsSpecificGamesViewController.h"
#import "TeamsSpecificGames.h"

@implementation TeamsSpecificGamesViewController

@synthesize teamGamesView;

@synthesize gameIds;
@synthesize gameHomeIds;
@synthesize gameAwayIds;
@synthesize gameHomeMaps;
@synthesize gameAwayMaps;
@synthesize gameFields;
@synthesize gameTimes;

@synthesize gameHomeNames;
@synthesize gameAwayNames;

@synthesize winningNames;
@synthesize losingNames;


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
	
	winningNames = [[NSMutableArray alloc] init];
	losingNames = [[NSMutableArray alloc] init];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	TeamsSpecificGames *teamSpecificGames = [[TeamsSpecificGames alloc] init];
	[teamSpecificGames queryServiceWithParent:self];
	
	
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
	if ([gameIds count] == 2)
		return 1;
	
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0)
		return [gameIds count]-2;
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([gameIds count] == 2)
		return @"No Games Scheduled";
	if (section == 0) {
		return @"Scheduled";
	}
	if (section == 1) {
		return @"If Win";
	}
	if (section == 2) {
		return @"If Lose";
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
	if (indexPath.section == 0){
		if (gameIds.count != 0) {
			
			int currentPosition = indexPath.row;
			
			if ([gameHomeIds objectAtIndex:currentPosition ] == @"none")
				cell.textLabel.text = [NSString stringWithFormat:@"%@ vs %@", [gameHomeMaps objectAtIndex: indexPath.row], [gameAwayMaps objectAtIndex: indexPath.row]];
			else
				cell.textLabel.text = [NSString stringWithFormat:@"%@ vs %@", [gameHomeNames objectAtIndex: indexPath.row],[gameAwayNames objectAtIndex: indexPath.row]];
			
			
			[cell.textLabel setFont:[UIFont boldSystemFontOfSize:12]];
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			[dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'-07:00'+00:00'"];
			NSDate *date = [dateFormat dateFromString:[gameTimes objectAtIndex: indexPath.row]];
			
			[dateFormat setDateFormat:@"hh:mm a"];
			
			//Optionally for time zone converstions
			[dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
			
			NSString *stringFromDate = [dateFormat stringFromDate:date];
			
			//NSLog(@"time before %@", [gameTimes objectAtIndex:indexPath.row]);
			
			//NSLog(@"date %@", date);
			
			// Convert date object to desired output format
			//[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
			//	dateStr = [dateFormat stringFromDate:date];  
			//	[dateFormat release];
			
			
			cell.detailTextLabel.text = [NSString stringWithFormat:@"Game %@ - %@", [gameIds objectAtIndex: indexPath.row], stringFromDate];
		}
		else {
			cell.textLabel.text = @"No Games";
		}
	}
	if (indexPath.section == 1){
		if (gameIds.count != 0) {
			
			int currentPosition = gameIds.count-2;
			
			if ([[gameHomeMaps objectAtIndex: currentPosition] rangeOfString:[NSString stringWithFormat:@"%@",[gameIds objectAtIndex:0]]].location == NSNotFound) {
				cell.textLabel.text = [NSString stringWithFormat:@"at (%@) %@ or %@", [gameHomeMaps objectAtIndex: currentPosition],  [winningNames objectAtIndex:0], [winningNames objectAtIndex:1]];
			} else {
				cell.textLabel.text = [NSString stringWithFormat:@"vs (%@) %@ or %@", [gameAwayMaps objectAtIndex: currentPosition],  [winningNames objectAtIndex:0], [winningNames objectAtIndex:1]];
			}
			
			[cell.textLabel setFont:[UIFont boldSystemFontOfSize:12]];
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			[dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'-07:00'+00:00'"];
			NSDate *date = [dateFormat dateFromString:[gameTimes objectAtIndex: currentPosition]];
			
			[dateFormat setDateFormat:@"hh:mm a"];
			
			//Optionally for time zone converstions
			[dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
			
			NSString *stringFromDate = [dateFormat stringFromDate:date];
			
			//NSLog(@"time before %@", [gameTimes objectAtIndex:indexPath.row]);
			
			//NSLog(@"date %@", date);
			
			// Convert date object to desired output format
			//[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
			//	dateStr = [dateFormat stringFromDate:date];  
			//	[dateFormat release];
			
			
			cell.detailTextLabel.text = [NSString stringWithFormat:@"Game %@ - %@", [gameIds objectAtIndex: currentPosition], stringFromDate];
		}
		else {
			cell.textLabel.text = @"No Games";
		}
	}
	if (indexPath.section == 2){
		if (gameIds.count != 0) {
			
			int currentPosition = gameIds.count-1;
			
			if ([[gameHomeMaps objectAtIndex: currentPosition] rangeOfString:[NSString stringWithFormat:@"%@",[gameIds objectAtIndex:0]]].location == NSNotFound) {
				cell.textLabel.text = [NSString stringWithFormat:@"at (%@) %@ or %@", [gameHomeMaps objectAtIndex: currentPosition],  [losingNames objectAtIndex:0], [losingNames objectAtIndex:1]];
			} else {
				cell.textLabel.text = [NSString stringWithFormat:@"vs (%@) %@ or %@", [gameAwayMaps objectAtIndex: currentPosition],  [losingNames objectAtIndex:0], [losingNames objectAtIndex:1]];
			}
			
			[cell.textLabel setFont:[UIFont boldSystemFontOfSize:12]];
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			[dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'-07:00'+00:00'"];
			NSDate *date = [dateFormat dateFromString:[gameTimes objectAtIndex: currentPosition]];
			
			[dateFormat setDateFormat:@"hh:mm a"];
			
			//Optionally for time zone converstions
			[dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
			
			NSString *stringFromDate = [dateFormat stringFromDate:date];
			
			//NSLog(@"time before %@", [gameTimes objectAtIndex:indexPath.row]);
			
			//NSLog(@"date %@", date);
			
			// Convert date object to desired output format
			//[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
			//	dateStr = [dateFormat stringFromDate:date];  
			//	[dateFormat release];
			
			
			cell.detailTextLabel.text = [NSString stringWithFormat:@"Game %@ - %@", [gameIds objectAtIndex: currentPosition], stringFromDate];
		}
		else {
			cell.textLabel.text = @"No Games";
		}
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
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
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
	
	 [teamGamesView release];
	
	 [gameIds release];
	 [gameHomeIds release];
	 [gameAwayIds release];
	 [gameHomeMaps release];
	 [gameAwayMaps release];
	 [gameFields release];
	 [gameTimes release];
	
	 [gameHomeNames release];
	 [gameAwayNames release];
	
	 [winningNames release];
	 [losingNames release];
    [super dealloc];
}


@end


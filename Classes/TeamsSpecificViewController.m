//
//  TeamsSpecificViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TeamsSpecificViewController.h"
#import "TeamsSpecific.h"
#import "TeamsSpecificGamesViewController.h"

@implementation TeamsSpecificViewController

@synthesize teamTableView;
@synthesize teamRecordCell;

@synthesize optionList;

@synthesize teamName;
@synthesize teamId;
@synthesize teamWins;
@synthesize teamLosses;
@synthesize teamGoals;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	// Create dummy category array, save, remove dummy
	NSArray *options = [[NSArray alloc] initWithObjects: @"Contact", @"Games", @"Updates", @"Standings", @"Discipline", nil];
	self.optionList = options;
	[options release];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	TeamsSpecific *teamsSpecific = [[TeamsSpecific alloc] init];
	[teamsSpecific queryServiceWithParent:self];
	
	
	
	
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
	
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0)
		return 1;
    return [optionList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    if (section == 0)
		return @"Position 1";
	else 
		return @"";

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	if (indexPath.section + indexPath.row == 0)
	{
		return 90;		
	}
    return 44; 
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	if (indexPath.section + indexPath.row == 0){
		
		NSLog(@"TEAMWINS : %@", teamWins);
		
		UILabel *winsLabel = (UILabel *)[teamRecordCell viewWithTag:1];
		winsLabel.text  = [NSString stringWithFormat:@"%@", teamWins];
		
		UILabel *lossesLabel = (UILabel *)[teamRecordCell viewWithTag:2];
		lossesLabel.text  = [NSString stringWithFormat:@"%@", teamLosses];
		
		UILabel *goalsLabel = (UILabel *)[teamRecordCell viewWithTag:3];
		goalsLabel.text  = [NSString stringWithFormat:@"%@", teamGoals];
		
		//UILabel *lossesLabel = (UILabel *)[teamRecordCell viewWithTag:2];
//		lossesLabel.text  = teamLosses;
//		
//		UILabel *goalsLabel = (UILabel *)[teamRecordCell viewWithTag:3];
//		goalsLabel.text  = teamGoals;
		
			return teamRecordCell;		
    }
    // Configure the cell...
    else{
		cell.textLabel.text = [optionList objectAtIndex:indexPath.row];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
	if (indexPath.section + indexPath.row != 0){ 
		
		if (indexPath.row == 1) {
			TeamsSpecificGamesViewController *teamsGamesView = [[TeamsSpecificGamesViewController alloc] init];
			teamsGamesView.navigationItem.title = (@"Games");
			[self.navigationController pushViewController:teamsGamesView animated:YES];
			[teamsGamesView release];
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
	 [teamTableView release];
	 [teamRecordCell release];
	
	 [optionList release];
	
	 [teamName release];
	 [teamId release];
	 [teamWins release];
	 [teamLosses release];
	 [teamGoals release];
	
    [super dealloc];
}


@end


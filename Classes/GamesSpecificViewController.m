//
//  GamesSpecificViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GamesSpecificViewController.h"
#import "GamesSpecific.h"


@implementation GamesSpecificViewController

@synthesize gameTableView;
@synthesize gameDetailsCell;

@synthesize gameId;
@synthesize awayId;
@synthesize homeId;
@synthesize awayMap;
@synthesize homeMap;
@synthesize awayScore;
@synthesize homeScore;
@synthesize round;
@synthesize time;
@synthesize status;

@synthesize awayName;
@synthesize homeName;
@synthesize awayWins;
@synthesize homeWins;
@synthesize awayLosses;
@synthesize homeLosses;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 
 // Create dummy category array, save, remove dummy
 
 [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
 GamesSpecific *gamesSpecific = [[GamesSpecific alloc] init];
 [gamesSpecific queryServiceWithParent:self];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    if (section == 0)
		return [NSString stringWithFormat:@"Round %@ - Game %@", round, gameId];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
	if (indexPath.section + indexPath.row == 0){
		UILabel *homeLabel = (UILabel *)[gameDetailsCell viewWithTag:1];
		homeLabel.text  = [NSString stringWithFormat:@"%@", homeName];
	
		UILabel *homeRecord = (UILabel *)[gameDetailsCell viewWithTag:2];
		homeRecord.text  = [NSString stringWithFormat:@"%@ - %@", homeWins, homeLosses];
		
		UILabel *homeGoals = (UILabel *)[gameDetailsCell viewWithTag:3];
		homeGoals.text  = [NSString stringWithFormat:@"%@", homeScore];
		
		UILabel *awayLabel = (UILabel *)[gameDetailsCell viewWithTag:4];
		awayLabel.text  = [NSString stringWithFormat:@"%@", awayName];
		
		UILabel *awayRecord = (UILabel *)[gameDetailsCell viewWithTag:5];
		awayRecord.text  = [NSString stringWithFormat:@"%@ - %@", awayWins, awayLosses];
		
		UILabel *awayGoals = (UILabel *)[gameDetailsCell viewWithTag:6];
		awayGoals.text  = [NSString stringWithFormat:@"%@", awayScore];
				
		return gameDetailsCell;		
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
    [super dealloc];
}


@end


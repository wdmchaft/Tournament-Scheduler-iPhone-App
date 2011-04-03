//
//  AboutViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//
//  StandingsViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutRulesViewController.h"
#import "AboutContactViewController.h"


@implementation AboutViewController

@synthesize aboutTableView;
@synthesize aboutContentCell;


#pragma mark -
#pragma mark View lifecycle

/*
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 }
 */

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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	if (indexPath.section + indexPath.row + 1 == 1)
	{
		return 286;		
	}
    return 44; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	if (indexPath.section + indexPath.row + 1 == 1)
	{
		return aboutContentCell;		
	}
	
	if (indexPath.section + indexPath.row + 1 == 2)
	{
		cell.textLabel.text = @"Rules";
		return cell;
	}
	
	if (indexPath.section + indexPath.row + 1 == 3)
	{
		cell.textLabel.text = @"Contact";
		return cell;
	}
	
	return cell;

	
		
}

// Adds selection type
- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section + indexPath.row + 1 == 1)
	{
		return UITableViewCellAccessoryNone;		
	}
	return UITableViewCellAccessoryDisclosureIndicator;
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

	if (indexPath.section + indexPath.row + 1 == 2){
	 AboutRulesViewController *aboutRulesView = [[AboutRulesViewController alloc] init];
	 aboutRulesView.navigationItem.title = (@"Rules");
	 // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:aboutRulesView animated:YES];
	 [aboutRulesView release];
	}
	
	else if (indexPath.section + indexPath.row + 1 == 3){
		AboutContactViewController *aboutContactView = [[AboutContactViewController alloc] init];
		aboutContactView.navigationItem.title = (@"Contact");
		// Pass the selected object to the new view controller.
		[self.navigationController pushViewController:aboutContactView animated:YES];
		[aboutContactView release];
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
    [super dealloc];
}


@end

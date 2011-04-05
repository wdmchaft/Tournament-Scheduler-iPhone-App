//
//  TeamsDivisionViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TeamsDivisionViewController.h"
#import "TeamsDivision.h"
#import "TournamentSchedulerAppDelegate.h"
#import "OverlayViewController.h"
#import "TeamsSpecificViewController.h"


@implementation TeamsDivisionViewController



@synthesize teamsDivisionTableView;

@synthesize teamIds;
@synthesize teamNames;

#pragma mark -
#pragma mark View lifecycle

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	teamNames = [[NSMutableArray alloc] init];
	teamIds = [[NSMutableArray alloc] init];
	NSLog(@"names = %@", teamNames);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	TeamsDivision *teamsDivision = [[TeamsDivision alloc] init];
	[teamsDivision queryServiceWithParent:self];
	
	copyOfTeamNames = [[NSMutableArray alloc] init];
	
	//Add the search bar
	self.teamsDivisionTableView.tableHeaderView = searchBar;
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	
	searching = NO;
	letUserSelectRow = YES;
	
    [super viewDidLoad];
	
	
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

//- (void)viewDidUnload {
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	NSLog(@"Table View - namescount = %d", teamNames.count);
	if (searching)
		return [copyOfTeamNames count];
	return teamNames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	if(searching)
		cell.textLabel.text = [copyOfTeamNames objectAtIndex:indexPath.row];
	else
		cell.textLabel.text = [teamNames objectAtIndex:indexPath.row];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//Add code to handle selection here
	NSString *teamName = @"";
	if(searching)
		teamName = [copyOfTeamNames objectAtIndex:indexPath.row];
	else
		teamName = [teamNames objectAtIndex:indexPath.row];
//	NSString *teamId = [teamIds objectAtIndex:indexPath.row];
//	
//	NSLog(@"Title is %@ with ID %@", divName, divId);
//	
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:teamName message:@"HELLO" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//	[alert show];
//	[alert autorelease];
//	
//	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
//	
//	delegate.tempIdHolder= divId;
//	//delegate.currentPage = title;
//	
//	
//	
	TeamsSpecificViewController *teamsSpecificView = [[TeamsSpecificViewController alloc] init];
	teamsSpecificView.navigationItem.title = (@"%@", teamName);
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil] autorelease];
	[self.navigationController pushViewController:teamsSpecificView animated:YES];
	[teamsSpecificView release];
//	
//	
//	
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Search Bar

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	NSLog(@"Begin Editing Entered");
	
	if(ovController == nil)
		ovController = [[OverlayViewController alloc] initWithNibName:@"OverlayView" bundle:[NSBundle mainBundle]];
	
	
	CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	
	//Parameters x = origion on x-axis, y = origon on y-axis.
	CGRect frame = CGRectMake(0, yaxis, width, height);
	ovController.view.frame = frame;
	ovController.view.backgroundColor = [UIColor grayColor];
	ovController.view.alpha = 0.5;
	
	ovController.rvController = self;
	
	[self.teamsDivisionTableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
	
	
	searching = YES;
	letUserSelectRow = NO;
	self.teamsDivisionTableView.scrollEnabled = NO;
	
	//Add the done button.
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneSearching_Clicked:)] autorelease];
}

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(letUserSelectRow)
		return indexPath;
	else
		return nil;
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
	
	//Remove all objects first.
	[copyOfTeamNames removeAllObjects];
	
	NSLog(@"copyOfTeamNames blanked");
	
	if([searchText length] > 0) {
		
		[ovController.view removeFromSuperview];
		searching = YES;
		letUserSelectRow = YES;
		self.teamsDivisionTableView.scrollEnabled = YES;
		//NSLog(@"We are searching");
		[self searchTableView];
	}
	else {
		//NSLog(@"We are not searching");
		searching = NO;
		letUserSelectRow = NO;
		self.teamsDivisionTableView.scrollEnabled = NO;
	}
	
	[self.teamsDivisionTableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	//NSLog(@"Search bar clicked");
	[self searchTableView];
}

- (void) searchTableView {
	
	NSString *searchText = searchBar.text;
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];
	
	[searchArray addObjectsFromArray:teamNames];
	NSLog(@"searchArray is %@", searchArray);
	
	for (NSString *sTemp in searchArray)
	{
		NSLog(@
			  "sTemp is %@", sTemp);
		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
		
		if (titleResultsRange.length > 0)
			[copyOfTeamNames addObject:sTemp];
	}
	
	[searchArray release];
	searchArray = nil;
}

//RootViewController.m
- (void) doneSearching_Clicked:(id)sender {
	
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	self.teamsDivisionTableView.scrollEnabled = YES;
	
	[ovController.view removeFromSuperview];
	[ovController release];
	ovController = nil;
	
	[self.teamsDivisionTableView reloadData];
}



- (void)dealloc {
	[teamsDivisionTableView release];
	[ovController release];
	[copyOfTeamNames release];
	[searchBar release];
	[teamNames release];
	[teamIds release];
    [super dealloc];
}

@end
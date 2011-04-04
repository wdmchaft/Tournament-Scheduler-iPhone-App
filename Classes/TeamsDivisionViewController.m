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
	return teamNames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.textLabel.text = [teamNames objectAtIndex:indexPath.row];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//Add code to handle selection here
	NSString *teamName = [teamNames objectAtIndex:indexPath.row];
	NSString *teamId = [teamIds objectAtIndex:indexPath.row];
//	
//	NSLog(@"Title is %@ with ID %@", divName, divId);
//	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:teamName message:@"HELLO" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert autorelease];
//	
//	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
//	
//	delegate.tempIdHolder= divId;
//	//delegate.currentPage = title;
//	
//	
//	
//	StandingsDivisionViewController *divisionStandingsView = [[StandingsDivisionViewController alloc] init];
//	divisionStandingsView.navigationItem.title = (@"%@", divName);
//	[delegate.standingsNavigationController pushViewController:divisionStandingsView animated:YES];
//	[divisionStandingsView release];
//	
//	
//	
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
	[teamNames dealloc];
	[teamIds dealloc];
    [super dealloc];
}

@end
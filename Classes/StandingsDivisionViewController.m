//
//  StandingsDivisionViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StandingsDivisionViewController.h"
#import "TournamentSchedulerAppDelegate.h"
#import "StandingsDivision.h"

@implementation StandingsDivisionViewController

// Syntehsize Names, points, wins, draws, and losses
@synthesize names;
@synthesize pts;
@synthesize wins;
@synthesize draws;
@synthesize losses;


@synthesize serviceView;

@synthesize myCell;

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
	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSLog(@"We are in the divisionStandingsViewController and the tempID is %@" , delegate.tempIdHolder); 
		  

	
	//self.navigationItem.title = @"CLICKED DIVISION";
	
	names = [[NSMutableArray alloc] init];
	pts = [[NSMutableArray alloc] init];
	wins = [[NSMutableArray alloc] init];
	draws = [[NSMutableArray alloc] init];
	losses = [[NSMutableArray alloc] init];
	NSLog(@"names = %@", names);
	NSLog(@"points = %@", pts);
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	StandingsDivision *standings = [[StandingsDivision alloc] init];
	[standings queryServiceWithParent:self];
	
	
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	return @"Team Name                    P  W  D  L";
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	NSLog(@"Table View - namescount = %d", names.count);
	return names.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"Hello");
	static NSString *CellIdentifier = @"Cell";
	
	//
	
	
	//
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		// load cell from nib to controller's IBOutlet
		[[NSBundle mainBundle] loadNibNamed:@"StandingsTableView" owner:self options:nil];
		// assign IBOutlet to cell
		cell = myCell;
		self.myCell = nil;
	}
	
	
	UILabel *label;
	label = (UILabel *)[cell viewWithTag:1];
	label.text = [names objectAtIndex:indexPath.row];
	
	label = (UILabel *)[cell viewWithTag:2];
	label.text = [[pts objectAtIndex:indexPath.row] stringValue];
	
	label = (UILabel *)[cell viewWithTag:3];
	label.text = [[wins objectAtIndex:indexPath.row] stringValue];
	
	label = (UILabel *)[cell viewWithTag:4];
	label.text = [[draws objectAtIndex:indexPath.row] stringValue];
	
	label = (UILabel *)[cell viewWithTag:5];
	label.text = [[losses objectAtIndex:indexPath.row] stringValue];
	
	
	cell.textLabel.font = [UIFont systemFontOfSize:12]; //Change this value to adjust size
	cell.textLabel.numberOfLines = 2; //Change this value to show more or less lines.
	NSLog(@"Name = %@ PTS = %@", [names objectAtIndex:indexPath.row], [pts objectAtIndex:indexPath.row] );
	//cell.textLabel.text = [names objectAtIndex:indexPath.row];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//Add code to handle selection here
	NSString *title = [names objectAtIndex:indexPath.row];
	
	NSLog(@"Title is %@", title);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"HELLO" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert autorelease];
	
	
	
	
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

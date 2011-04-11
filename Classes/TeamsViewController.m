//
//  TeamsViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TeamsViewController.h"
#import "Teams.h"
#import "TournamentSchedulerAppDelegate.h"
#import "TeamsDivisionViewController.h"


@implementation TeamsViewController

@synthesize teamsView;
@synthesize names;
@synthesize ids;

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
	
	names = [[NSMutableArray alloc] init];
	ids = [[NSMutableArray alloc] init];
	//	NSLog(@"names = %@", names);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	Teams *teams = [[Teams alloc] init];
	[teams queryServiceWithParent:self];
	
	UIColor *aColor = [UIColor colorWithHue:0.964 saturation:0.443 brightness:0.867 alpha:1.000];
	self.navigationController.navigationBar.tintColor = aColor; 
	
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
	
//	NSLog(@"Table View - namescount = %d", names.count);
	return names.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//	NSLog(@"Hello");
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
//	NSLog(@"Create Cell = %@", [names objectAtIndex:indexPath.row]);
	if (indexPath.row == 0)
		cell.textLabel.text = @"All Teams";
	else
		cell.textLabel.text = [names objectAtIndex:indexPath.row-1];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//Add code to handle selection here
	
	NSString *divName = @"";
	NSString *divId = @"";
	if (indexPath.row == 0){
		divName = @"All Teams";
		divId = @"0";	
	}else{
		divName = [names objectAtIndex:indexPath.row-1];
		divId = [ids objectAtIndex:indexPath.row-1];
	}
	
	
//	
//	NSLog(@"Title is %@ with ID %@", divName, divId);
//	
	//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:divName message:@"HELLO" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//	[alert show];
//	[alert autorelease];
//	
	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
//	
	delegate.tempIdHolder= divId;
	delegate.currentPage = divName;
//	
//	
//	
	TeamsDivisionViewController *teamsDivisionView = [[TeamsDivisionViewController alloc] init];
	teamsDivisionView.navigationItem.title = (@"%@", divName);
	[self.navigationController pushViewController:teamsDivisionView animated:YES];
	[teamsDivisionView release];


	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
	[teamsView release];
	[names release];
	[ids release];
    [super dealloc];
}


@end

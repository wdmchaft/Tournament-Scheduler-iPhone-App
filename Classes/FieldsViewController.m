//
//  FieldsViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "FieldsViewController.h"
#import "Fields.h"
#import "TournamentSchedulerAppDelegate.h"


@implementation FieldsViewController;

@synthesize fieldsTableView;
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
	Fields *fields = [[Fields alloc] init];
	[fields queryServiceWithParent:self];
	
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


- (void)dealloc {
	[names dealloc];
	[ids dealloc];
    [super dealloc];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	//	NSLog(@"Table View - namescount = %d", names.count);
	return names.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	//	NSLog(@"Hello");
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	NSLog(@"Create Cell = %@", [ids objectAtIndex:indexPath.row]);
	cell.textLabel.text = [NSString stringWithFormat:@"Field %@", [ids objectAtIndex:indexPath.row]];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//Add code to handle selection here
	
	NSString *divName = [names objectAtIndex:indexPath.row];
	NSString *divId = [ids objectAtIndex:indexPath.row];
	
	
	NSLog(@"Title is %@ with ID %@", divName, divId);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:divName message:@"HELLO" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert autorelease];
	//	
	//TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
	//	//	
	//	delegate.tempIdHolder= divId;
	//	delegate.currentPage = divName;
	//	//	
	//	//	
	//	//	
	//	TeamsDivisionViewController *teamsDivisionView = [[TeamsDivisionViewController alloc] init];
	//	teamsDivisionView.navigationItem.title = (@"%@", divName);
	//	[self.navigationController pushViewController:teamsDivisionView animated:YES];
	//	[teamsDivisionView release];
	
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

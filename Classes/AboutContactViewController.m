//
//  AboutContactViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutContactViewController.h"


@implementation AboutContactViewController

@synthesize aboutContactTableView;
@synthesize categoryList;
@synthesize categoryCountList;
@synthesize nameList;
@synthesize imageList;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	
	// Create dummy category array, save, remove dummy
	NSArray *categories = [[NSArray alloc] initWithObjects: @"Tournament Owner", @"Administrators", @"Site/ App Developer", nil];
	self.categoryList = categories;
	[categories release];
	
	// Create dummy categoryCount array, save, remove dummy
	NSArray *categoryCount = [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], nil];
	self.categoryCountList = categoryCount;
	[categoryCount release];
	
	// Create dummy name array, save, remove dummy
	NSArray *names = [[NSArray alloc] initWithObjects: @"Robert Thomas", @"Brian Dudley", @"Karen Dudley", @"Philip Dudley", nil];
	self.nameList = names;
	[names release];
	
	// Create dummy image array, save, remove dummy
	UIImage *robertThomas = [UIImage imageNamed:@"robertThomas.png"];
	UIImage *brianDudley = [UIImage imageNamed:@"brianDudley.png"];
	UIImage *karenDudley = [UIImage imageNamed:@"karenDudley.png"];
	UIImage *philipDudley = [UIImage imageNamed:@"philDudley.png"];
	NSArray *images = [[NSArray alloc] initWithObjects: robertThomas, brianDudley, karenDudley, philipDudley, nil];
	self.imageList = images;
	
	// Release the dummy array
	[images release];
	
	// Release the UIImage objects
	[robertThomas release];
	[brianDudley release];
	[karenDudley release];
	[philipDudley release];
	
    [super viewDidLoad];

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
    return categoryList.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [[categoryCountList objectAtIndex:section] intValue];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return [categoryList objectAtIndex:section];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
	
	// Set the title for the cell
	if(indexPath.section == 0){
		cell.textLabel.text = [nameList objectAtIndex:0];
		cell.imageView.image = [imageList objectAtIndex:0];
	}else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			cell.textLabel.text = [nameList objectAtIndex:1];
			cell.imageView.image = [imageList objectAtIndex:1];
		}
		else {
			cell.textLabel.text = [nameList objectAtIndex:2];
			cell.imageView.image = [imageList objectAtIndex:2];
		}
	}
	else {
		cell.textLabel.text = [nameList objectAtIndex:3];
		
		// Set the tableview image for the cell
		cell.imageView.image = [imageList objectAtIndex:3];
	}

	
	
	// Set the accessory view for the cell
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	// Return the cell
    
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


//
//  AboutContactDetailViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutContactDetailViewController.h"


@implementation AboutContactDetailViewController

@synthesize headerView;
@synthesize footerView;

@synthesize imageLarge;
@synthesize mainTitle;
@synthesize subTitle;
@synthesize mobile;
@synthesize email;



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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	
	UIImageView *imageView = (UIImageView *)[headerView viewWithTag:1];
	imageView.image = imageLarge;
	
	UILabel *nameLabel = (UILabel *)[headerView viewWithTag:2];
	nameLabel.text  = mainTitle;
	
	UILabel *titleLabel = (UILabel *)[headerView viewWithTag:3];
	titleLabel.text  = subTitle;
	
	
	
	
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 105;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

	
	
	
	
	
	return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 92;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (mainTitle == @"Philip Dudley") {
		return 3;
	}
	
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
	
	if (indexPath.row == 0) {
		cell.textLabel.text = @"mobile";
		cell.detailTextLabel.text = mobile;
	}
	else if(indexPath.row == 1){
		cell.textLabel.text = @"email";
		cell.detailTextLabel.text = email;
	}
	
	else if (indexPath.row == 2) {
		cell.textLabel.text = @"site";
		cell.detailTextLabel.text = @"www.phildudley.com";
	}
	
		

    
    // Configure the cell...
    
    return cell;
}

- (IBAction) addContact:(id) sender
{
	NSLog(@"TEST");
}

- (IBAction) textMessage:(id) sender
{	
	NSString *prefix = @"sms://";
	NSString *theUrl =[prefix stringByAppendingString:mobile];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: theUrl]];
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
    
	if (indexPath.row == 0) {
		NSString *prefix = @"tel://";
		NSString *theUrl =[prefix stringByAppendingString:mobile];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: theUrl]];
	}
	else if(indexPath.row == 1){
		NSString *prefix = @"mailto:";
		NSString *theUrl =[prefix stringByAppendingString:email];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: theUrl]];
		//cell.textLabel.text = @"email";
		//cell.detailTextLabel.text = email;
	}
	
	else if (indexPath.row == 2) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.phildudley.com"]];
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
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


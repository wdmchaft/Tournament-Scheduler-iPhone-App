//
//  DivisionStandings.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DivisionStandings.h"
#import "JSON.h"
#import "DivisionStandingsViewController.h"
#import "TournamentSchedulerAppDelegate.h"


@implementation DivisionStandings





- (void)queryServiceWithParent:(UIViewController *)controller {
	viewController = (DivisionStandingsViewController *)controller;
	responseData = [[NSMutableData data] retain];
	
	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *tempId= delegate.tempIdHolder;
	
	NSString *url = [NSString stringWithFormat:@"http://localhost:4567/api/standings/division/%@",tempId];
	theURL = [[NSURL URLWithString:url] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:theURL];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse {
	[theURL autorelease];
	theURL = [[request URL] retain];
	NSLog(@"URL = %@", theURL);
	return request;
}

-(void)connection:(NSURLConnection *)connection didRecieveResponse:(NSURLResponse *)response{
	[responseData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
	
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	// Handle Error
	NSLog(@"UHOH ERROR");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	NSString *content = [[NSString alloc] initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
	NSLog(@"Data = %@", content);
	
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSArray *trends = [parser objectWithString:content];
	
	for (NSDictionary *trend in trends) {
		NSLog(@"Name = %@", [trend objectForKey:@"name"]);
		NSLog(@"Points = %@", [trend objectForKey:@"points"]);
		[viewController.names addObject:[trend objectForKey:@"name"]];
		[viewController.pts addObject:[trend objectForKey:@"points"]];
		[viewController.wins addObject:[trend objectForKey:@"wins"]];
		[viewController.draws addObject:[trend objectForKey:@"ties"]];
		[viewController.losses addObject:[trend objectForKey:@"losses"]];
	}
	NSLog(@"names count = %@", viewController.names);
	NSLog(@"points count = %@", viewController.pts);
	[parser release];
	NSLog(@"Parser Released");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSLog(@"Network Indicator Disabled");
	[viewController.serviceView reloadData];
}

-(void)dealloc{
	[viewController release];
	[responseData release];
	[theURL release];
	[super dealloc];
}



@end


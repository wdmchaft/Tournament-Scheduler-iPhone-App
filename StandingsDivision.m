//
//  StandingsDivision.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StandingsDivision.h"
#import "JSON.h"
#import "StandingsDivisionViewController.h"
#import "TournamentSchedulerAppDelegate.h"


@implementation StandingsDivision





- (void)queryServiceWithParent:(UIViewController *)controller {
	viewController = (StandingsDivisionViewController *)controller;
	responseData = [[NSMutableData data] retain];
	
	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *tempId= delegate.tempIdHolder;
	
	NSString *url = [NSString stringWithFormat:@"http://tournament-scheduler.heroku.com/api/standings/division/%@",tempId];
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
	
	NSError *error;
	NSDictionary *json = [parser objectWithString:content error:&error];
	
	if(json == nil){
		UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[errorAlert show];
		[errorAlert release];
	}else {
	
		for (NSDictionary *trend in trends) {
			NSLog(@"Name = %@", [trend objectForKey:@"name"]);
			NSLog(@"Points = %@", [trend objectForKey:@"points"]);
			[viewController.teamIds addObject:[trend objectForKey:@"id"]];
			[viewController.names addObject:[trend objectForKey:@"name"]];
			[viewController.pts addObject:[trend objectForKey:@"points"]];
			[viewController.wins addObject:[trend objectForKey:@"wins"]];
			//[viewController.draws addObject:[trend objectForKey:@"ties"]];
			[viewController.losses addObject:[trend objectForKey:@"losses"]];
			[viewController.goals addObject:[trend objectForKey:@"goals"]];
		}
		[parser release];
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[viewController.serviceView reloadData];
}

-(void)dealloc{
	[viewController release];
	[responseData release];
	[theURL release];
	[super dealloc];
}



@end


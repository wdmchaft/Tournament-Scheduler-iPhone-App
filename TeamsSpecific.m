//
//  TeamsSpecific.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TeamsSpecific.h"
#import "JSON.h"
#import "TeamsSpecificViewController.h"
#import "TournamentSchedulerAppDelegate.h"


@implementation TeamsSpecific


- (void)queryServiceWithParent:(UIViewController *)controller {
	viewController = (TeamsSpecificViewController *)controller;
	responseData = [[NSMutableData data] retain];
	
	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *tempId= delegate.tempIdHolder;
	
	NSString *url = [NSString stringWithFormat:@"http://tournament-scheduler.heroku.com/api/teams/%@",tempId];
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
	
	NSDictionary *trends = [parser objectWithString:content];
	
	NSLog(@"Trends = %@", trends);
	
	NSError *error;
	NSDictionary *json = [parser objectWithString:content error:&error];
	
	if(json == nil){
		UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[errorAlert show];
		[errorAlert release];
	}else {
		NSLog(@"GOALS AGAINST");
		viewController.teamName = [trends objectForKey:@"name"];
		viewController.teamId = [trends objectForKey:@"id"];
		viewController.teamWins = [trends objectForKey:@"wins"];
		viewController.teamLosses = [trends objectForKey:@"losses"];
		viewController.teamGoals = [trends objectForKey:@"goals"];
		viewController.teamGoalsAgainst = [trends objectForKey:@"goals_against"];
		
		NSLog(@"Teaaaaam Name %@", viewController.teamName);
			
		[parser release];
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[viewController.teamTableView reloadData];
}

-(void)dealloc{
	[viewController release];
	[responseData release];
	[theURL release];
	[super dealloc];
}



@end


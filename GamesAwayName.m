//
//  GamesAwayName.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSON.h"
#import "GamesAwayName.h"
#import "GamesDivisionViewController.h"
#import "TournamentSchedulerAppDelegate.h"


@implementation GamesAwayName

- (void)queryServiceWithParent:(UIViewController *)controller {
	viewController = (GamesDivisionViewController *)controller;
	responseData = [[NSMutableData data] retain];
	
	
	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *tempId= delegate.tempIdHolder;
	
	
	NSString *url = [NSString stringWithFormat:@"http://localhost:4567/api/teams/%@", tempId];
	theURL = [[NSURL URLWithString:url] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:theURL];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
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
	UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[errorAlert show];
	[errorAlert release];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	NSString *content = [[NSString alloc] initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
	NSLog(@"Data = %@", content);
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	
	NSError *error;
	NSDictionary *json = [parser objectWithString:content error:&error];
	
	if(json == nil){
		UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[errorAlert show];
		[errorAlert release];
	}else {
		
		NSDictionary *trend = [parser objectWithString:content];
		//NSLog(@"trends = %@", trends);
		
		
		//NSLog(@"trend = %@", trend);
		// Get game id/ home team id / away id 
		
		
		
		
		NSLog(@"Name = %@", [trend objectForKey:@"name"]);
		
		
		[viewController.gameAwayNames addObject:[trend objectForKey:@"name"]];
		
		
		// If the trend id is the current delegate key id done :)
		TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
		NSString *tempId= delegate.tempIdHolder;
		if (tempId == [trend objectForKey:@"id"]) {
			NSLog(@"LastOne");
			[viewController.gamesDivisionTableView reloadData];
		}
	}
	//NSLog(@"viewController.gameHomeIds = %@", viewController.gameHomeIds);
	[parser release];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	
	
	
}

-(void)dealloc{
	[viewController release];
	[responseData release];
	[theURL release];
	[super dealloc];
}



@end


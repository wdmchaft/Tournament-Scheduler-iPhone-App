//
//  StandingsDivision.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TeamsDivision.h"
#import "JSON.h"
#import "TeamsDivisionViewController.h"
#import "TournamentSchedulerAppDelegate.h"


@implementation TeamsDivision


- (void)queryServiceWithParent:(UIViewController *)controller {
	viewController = (TeamsDivisionViewController *)controller;
	responseData = [[NSMutableData data] retain];
	
	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *tempId= delegate.tempIdHolder;
	NSString *url = [NSString stringWithFormat:@"http://localhost:4567/api/teams/"];
	
	if (tempId != @"0")
		url = [NSString stringWithFormat:@"http://localhost:4567/api/teams/division/%@",tempId];
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
			[viewController.teamNames addObject:[trend objectForKey:@"name"]];
			[viewController.teamIds addObject:[trend objectForKey:@"id"]];
		}
		[parser release];
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[viewController.teamsDivisionTableView reloadData];
}

-(void)dealloc{
	[viewController release];
	[responseData release];
	[theURL release];
	[super dealloc];
}



@end


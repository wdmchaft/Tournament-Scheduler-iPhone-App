//
//  GamesSpecific.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GamesSpecific.h"
#import "JSON.h"
#import "GamesSpecificViewController.h"
#import "TournamentSchedulerAppDelegate.h"


@implementation GamesSpecific


- (void)queryServiceWithParent:(UIViewController *)controller {
	viewController = (GamesSpecificViewController *)controller;
	responseData = [[NSMutableData data] retain];
	
	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *tempId= delegate.tempIdHolder;
	
	NSString *url = [NSString stringWithFormat:@"http://localhost:4567/api/games/%@",tempId];
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
		
		viewController.gameId = [trends objectForKey:@"id"];
		viewController.awayId = [trends objectForKey:@"away_id"];
		viewController.homeId = [trends objectForKey:@"home_id"];
		viewController.awayMap = [trends objectForKey:@"away_map"];
		viewController.homeMap = [trends objectForKey:@"home_map"];
		viewController.awayScore = [trends objectForKey:@"away_score"];
		viewController.homeScore = [trends objectForKey:@"home_score"];
		viewController.round = [trends objectForKey:@"round"];
		viewController.status = [trends objectForKey:@"status"];
		
//		NSLog(@"Team Name %@", viewController.teamName);
		
		[parser release];
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[viewController.gameTableView reloadData];
}

-(void)dealloc{
	[viewController release];
	[responseData release];
	[theURL release];
	[super dealloc];
}



@end


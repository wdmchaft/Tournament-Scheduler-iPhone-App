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
	
	NSString *url = [NSString stringWithFormat:@"http://tournament-scheduler.heroku.com/api/games/%@",tempId];
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

		if ([trends objectForKey:@"home_id"] != [NSNull null]) {
			viewController.homeId = [trends objectForKey:@"home_id"];
			viewController.awayId = [trends objectForKey:@"away_id"];
		}
		else {
			viewController.homeId = @"none";
			viewController.awayId = @"none";
		}
		
		
		viewController.awayMap = [trends objectForKey:@"away_map"];
		viewController.homeMap = [trends objectForKey:@"home_map"];
		viewController.awayScore = [trends objectForKey:@"away_score"];
		viewController.homeScore = [trends objectForKey:@"home_score"];
		viewController.round = [trends objectForKey:@"round"];
		viewController.time = [trends objectForKey:@"time"];
		viewController.status = [trends objectForKey:@"status"];
		
		// QUERY Field for field name
		
		responseData = [[NSMutableData data] retain];
		
		NSString *url = [NSString stringWithFormat:@"http://tournament-scheduler.heroku.com/api/fields/%@", [trends objectForKey:@"field_id"]];
		theURL = [[NSURL URLWithString:url] retain];
		
		NSURLRequest *request = [NSURLRequest requestWithURL:theURL];
		NSURLResponse *response = nil;
		NSError *error = nil;
		//getting the data
		NSData *newData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
		//json parse
		NSString *responseString = [[NSString alloc] initWithData:newData encoding:NSUTF8StringEncoding];
		NSDictionary *jsonObject = [responseString JSONValue];
		//Accessing JSON content
		viewController.field = [jsonObject objectForKey:@"name"];
		
		
		if (viewController.homeId != @"none"){
			TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
			delegate.tempIdHolder = viewController.homeId;
			
			responseData = [[NSMutableData data] retain];
			
			NSString *url = [NSString stringWithFormat:@"http://tournament-scheduler.heroku.com/api/teams/%@", delegate.tempIdHolder];
			theURL = [[NSURL URLWithString:url] retain];
			
			NSURLRequest *request = [NSURLRequest requestWithURL:theURL];
			NSURLResponse *response = nil;
			NSError *error = nil;
			//getting the data
			NSData *newData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
			//json parse
			NSString *responseString = [[NSString alloc] initWithData:newData encoding:NSUTF8StringEncoding];
			NSDictionary *jsonObject = [responseString JSONValue];
			//Accessing JSON content
			NSLog(@"Home name :  %@", [jsonObject objectForKey:@"name"] );
			
			viewController.homeName = [jsonObject objectForKey:@"name"];
			viewController.homeWins = [jsonObject objectForKey:@"wins"];
			viewController.homeLosses = [jsonObject objectForKey:@"losses"];
		}
		
		if (viewController.awayId != @"none"){
			TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
			delegate.tempIdHolder = viewController.awayId;
			
			responseData = [[NSMutableData data] retain];
			
			NSString *url = [NSString stringWithFormat:@"http://tournament-scheduler.heroku.com/api/teams/%@", delegate.tempIdHolder];
			theURL = [[NSURL URLWithString:url] retain];
			
			NSURLRequest *request = [NSURLRequest requestWithURL:theURL];
			NSURLResponse *response = nil;
			NSError *error = nil;
			//getting the data
			NSData *newData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
			//json parse
			NSString *responseString = [[NSString alloc] initWithData:newData encoding:NSUTF8StringEncoding];
			NSDictionary *jsonObject = [responseString JSONValue];
			//Accessing JSON content
			NSLog(@"Away name :  %@", [jsonObject objectForKey:@"name"] );
			
			viewController.awayName = [jsonObject objectForKey:@"name"];
			viewController.awayWins = [jsonObject objectForKey:@"wins"];
			viewController.awayLosses = [jsonObject objectForKey:@"losses"];
		}
		
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


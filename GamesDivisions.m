//
//  GamesDivisions.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 4/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSON.h"
#import "GamesDivisions.h"
#import "GamesDivisionViewController.h"
#import "TournamentSchedulerAppDelegate.h"
#import "GamesHomeName.h"
#import "GamesAwayName.h"


@implementation GamesDivisions

- (void)queryServiceWithParent:(UIViewController *)controller {
	viewController = (GamesDivisionViewController *)controller;
	responseData = [[NSMutableData data] retain];
	
	
	TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *tempId= delegate.tempIdHolder;
	
	NSString *url = [NSString stringWithFormat:@"http://localhost:4567/api/games/division/%@", tempId];
	theURL = [[NSURL URLWithString:url] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:theURL];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse {
	[theURL autorelease];
	theURL = [[request URL] retain];
	//NSLog(@"URL = %@", theURL);
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
	//NSLog(@"Data = %@", content);
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	
	NSError *error;
	NSDictionary *json = [parser objectWithString:content error:&error];
	
	if(json == nil){
		UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[errorAlert show];
		[errorAlert release];
	}else {
		
		
		NSArray *trends = [parser objectWithString:content];
		//NSLog(@"trends = %@", trends);
		
		for (NSDictionary *trend in trends) {
			
			//NSLog(@"trend = %@", trend);
			// Get game id/ home team id / away id 
			//NSLog(@"z = %@", [trend objectForKey:@"home_id"]);
			[viewController.gameIds addObject:[trend objectForKey:@"id"]];
			if ([trend objectForKey:@"home_id"] != [NSNull null]) {
				[viewController.gameHomeIds addObject:[trend objectForKey:@"home_id"]];
				[viewController.gameAwayIds addObject:[trend objectForKey:@"away_id"]];
				
				
			}
			else {
				[viewController.gameHomeIds addObject:@"none"];
				[viewController.gameAwayIds addObject:@"none"];
			}

			
			[viewController.gameHomeMaps addObject:[trend objectForKey:@"home_map"]];
			[viewController.gameAwayMaps addObject:[trend objectForKey:@"away_map"]];
			[viewController.gameFields addObject:[trend objectForKey:@"field_id"]];
			[viewController.gameTimes addObject:[trend objectForKey:@"time"]];
		}
		
	}
	
	
	// QUERY HOME TEAMS
	for (int i =0; i <  [viewController.gameHomeIds count]; i++){
		//NSLog(@"we have a home team");
		
		//NSLog(@"Team %@", [viewController.gameHomeIds objectAtIndex:i ]);
		if ([viewController.gameHomeIds objectAtIndex:i ] != @"none"){
			//NSLog(@"Team has an id");
			TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
			delegate.tempIdHolder= [viewController.gameHomeIds objectAtIndex:i];
			
			
			GamesHomeName *gamesHomeNames = [[GamesHomeName alloc] init];
			[gamesHomeNames queryServiceWithParent:viewController];
		}
		else{
			break;
		}
	}
	
	for (int i =0; i <  [viewController.gameAwayIds count]; i++){
		//NSLog(@"we have an away team");
		
		//NSLog(@"Team %@", [viewController.gameAwayIds objectAtIndex:i ]);
		if ([viewController.gameAwayIds objectAtIndex:i ] != @"none"){
			//NSLog(@"Team has an id");
			TournamentSchedulerAppDelegate *delegate = (TournamentSchedulerAppDelegate *)[[UIApplication sharedApplication] delegate];
			delegate.tempIdHolder= [viewController.gameAwayIds objectAtIndex:i];
			
			
			GamesAwayName *gamesAwayNames = [[GamesAwayName alloc] init];
			[gamesAwayNames queryServiceWithParent:viewController];
		}
		else{
			
			break;
		}
		
	}
	[parser release];
	//[viewController.gamesDivisionTableView reloadData];

}

-(void)dealloc{
	[viewController release];
	[responseData release];
	[theURL release];
	[super dealloc];
}



@end


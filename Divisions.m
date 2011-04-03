//
//  TwitterTrends.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 3/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSON.h"
#import "Divisions.h"
#import "StandingsViewController.h"


@implementation Divisions

	- (void)queryServiceWithParent:(UIViewController *)controller {
		viewController = (StandingsViewController *)controller;
		responseData = [[NSMutableData data] retain];
		
		NSString *url = [NSString stringWithFormat:@"http://localhost:4567/api/divisions/"];
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
		//NSLog(@"Name = %@", [trend objectForKey:@"name"]);
		[viewController.names addObject:[trend objectForKey:@"name"]];
		[viewController.urls addObject:[trend objectForKey:@"id"]];
	}
	NSLog(@"names count = %@", viewController.names);
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

//
//  DisplayMap.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DisplayMap.h"


@implementation DisplayMap

@synthesize coordinate,title,subtitle;

-(void)dealloc{
	[subtitle release];
	[title release];
	[super dealloc];
}

@end

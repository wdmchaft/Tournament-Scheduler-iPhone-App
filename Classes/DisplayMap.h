//
//  DisplayMap.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>


@interface DisplayMap : NSObject <MKAnnotation> {
	
	CLLocationCoordinate2D coordinate; 
	NSString *title; 
	NSString *subtitle;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;

@end

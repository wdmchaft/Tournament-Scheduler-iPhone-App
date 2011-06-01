//
//  SiteMapViewController.h
//  TournamentScheduler
//
//  Created by Philip Dudley on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class DisplayMap;

@interface SiteMapViewController : UIViewController <MKMapViewDelegate> {
	
	IBOutlet MKMapView *mapView;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end


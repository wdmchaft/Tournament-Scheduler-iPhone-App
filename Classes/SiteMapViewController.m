//
//  SiteMapViewController.m
//  TournamentScheduler
//
//  Created by Philip Dudley on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SiteMapViewController.h"
#import "DisplayMap.h"

@implementation SiteMapViewController

@synthesize mapView;


/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[mapView setMapType:MKMapTypeStandard];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	
//http://maps.google.com/maps?f=q&source=s_q&hl=en&q=UMASS,+280+Hicks+Way,+Amherst,+Hampshire,+Massachusetts+01003&aq=&sll=42.464237,-71.225393&sspn=0.652422,1.433716&ie=UTF8&geocode=FULVhgIdR1Ct-w&split=0&hq=&hnear=UMASS,+280+Hicks+Way,+Amherst,+Hampshire,+Massachusetts+01003&ll=42.385913,-72.533605&spn=0.005103,0.011201&z=17
//42.464237,-71.225393
// 0.652422,1.433716 
// ll=42.385913,-72.533605
// &spn=0.005103,0.011201&z=17	
	MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
	region.center.latitude = 42.385913 ;
	region.center.longitude = -72.533605;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapView setRegion:region animated:YES]; 
	
	[mapView setDelegate:self];
	
	
	// START FIELD 1
	
	DisplayMap *field1 = [[DisplayMap alloc] init]; 
	field1.title = @"Boyden 1";
	CLLocationCoordinate2D coordinate1;
    coordinate1.latitude = 42.38739520612153;
    coordinate1.longitude = -72.53635168075562;
	field1.coordinate = coordinate1;
	[mapView addAnnotation:field1];
	
	DisplayMap *field2 = [[DisplayMap alloc] init]; 
	field2.title = @"Boyden 2";
	CLLocationCoordinate2D coordinate2;
    coordinate2.latitude = 42.387617087743486;
    coordinate2.longitude = -72.53542900085449;
	field2.coordinate = coordinate2;
	[mapView addAnnotation:field2];
	
	DisplayMap *field3 = [[DisplayMap alloc] init]; 
	field3.title = @"Boyden 3";
	CLLocationCoordinate2D coordinate3;
    coordinate3.latitude = 42.38780727136665;
    coordinate3.longitude = -72.53442049026489;
	field3.coordinate = coordinate3;
	[mapView addAnnotation:field3];
}



-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		static NSString *defaultPinID = @"com.invasivecode.pin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
										  initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
		
		pinView.pinColor = MKPinAnnotationColorRed; 
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
	} 
	else {
		[mapView.userLocation setTitle:@"I am here"];
	}
	return pinView;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mapView release];
    [super dealloc];
}

@end

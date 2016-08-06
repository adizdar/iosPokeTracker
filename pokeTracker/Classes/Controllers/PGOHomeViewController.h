//
//  PGOHomeViewController.h
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface PGOHomeViewController : UIViewController <CLLocationManagerDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

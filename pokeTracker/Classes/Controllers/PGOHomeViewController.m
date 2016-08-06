//
//  PGOHomeViewController.m
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import "PGOHomeViewController.h"
#import "PGOLocationApiManager.h"
#import "PGOLocationModel.h"
#import "PGOPokemnListModel.h"

@interface PGOHomeViewController()
@property (weak, nonatomic) IBOutlet UISearchBar *locationSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *pokemonTable;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation PGOHomeViewController

NSArray *tableData;
PGOPokemnListModel *pokemonList;
NSMutableArray *pokemonLocations;
NSInteger numberOfPokemon;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pokemonTable.delegate = self;
    self.pokemonTable.dataSource = self;
    
    pokemonList = [PGOPokemnListModel new];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationSearchBar.delegate = self;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.zoomEnabled = YES;
    
}

- (IBAction)getUserLocation:(UIButton *)sender
{
    [self.locationManager startUpdatingLocation];
}

- (void)initMap: (CLLocationCoordinate2D)coordinates
{
    CLLocationCoordinate2D region;
    
    region.longitude = coordinates.longitude;
    region.latitude = coordinates.latitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(region, 1100, 1100);
    
    viewRegion.center = coordinates;
    pokemonLocations = [[NSMutableArray alloc] init];
    
    [self setPokemonOnMap: coordinates pokemonName: -1 addPokemonTopMap: YES];
    
    [self.mapView setRegion: viewRegion animated: YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
    PGOLocationRequestModel *requestModel = [PGOLocationRequestModel new];
    
    requestModel.longitude = [NSString stringWithFormat: @"%f", self.locationManager.location.coordinate.longitude];
    requestModel.latitude = [NSString stringWithFormat: @"%f", self.locationManager.location.coordinate.latitude];
    
    NSLog(@"%@", theLocation);
    [self searchForPokemonViaRequestModel: requestModel];
}

- (void)searchBarSearchButtonClicked: (UISearchBar*)searchBar
{
    NSString *city = searchBar.text; //@"New York, New York";
    CLGeocoder *geocoder = [CLGeocoder new];
    
    [searchBar resignFirstResponder];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            [geocoder geocodeAddressString:city completionHandler:^(NSArray *placemarks, NSError *error) {
                if (error) {
                    NSLog(@"Error: %@", [error localizedDescription]);
                    return;
                }
                
                if ([placemarks count] > 0) {
                    CLPlacemark *placemark = [placemarks lastObject]; // firstObject is iOS7 only.

                    PGOLocationRequestModel *requestModel = [PGOLocationRequestModel new];
                    
                    requestModel.longitude = [NSString stringWithFormat: @"%f", placemark.location.coordinate.longitude];
                    requestModel.latitude = [NSString stringWithFormat: @"%f", placemark.location.coordinate.latitude];
                    
                    [self searchForPokemonViaRequestModel: requestModel];
                }
            }];
        }
    });
}

- (void)setPokemonOnMap: (CLLocationCoordinate2D)coordinates pokemonName: (NSInteger )name addPokemonTopMap: (BOOL)add
{
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        @autoreleasepool {
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    
    [annotation setCoordinate: coordinates];
    [annotation setTitle: [NSString stringWithFormat: @"%ld", (long)name]];
    
    [pokemonLocations addObject: annotation];
    
    NSLog(@"%lu", (unsigned long)[pokemonLocations count]);
    
    if (add) {
        [self.mapView addAnnotations: pokemonLocations];
    }
    
    //        }
    //    });
}

- (void)searchForPokemonViaRequestModel: (PGOLocationRequestModel *)requestModel
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            [[PGOLocationApiManager sharedManager] getLocationsWithRequestModel: requestModel
                                                                        success:^(PGOLocationResponseModel *responseModel) {
                                                                            if (![responseModel.pokemons count]) {NSLog(@"%@", @"NOT"); return;}
                                                                            
                                                                            CLLocationCoordinate2D cordinates;
                                                                            
                                                                            tableData = responseModel.pokemons;
                                                                            cordinates.latitude = [requestModel.latitude doubleValue];
                                                                            cordinates.longitude = [requestModel.longitude doubleValue];
                                                                            
                                                                            [self.pokemonTable reloadData];
                                                                            [self initMap: cordinates];
                                                                            
                                                                            for (PGOLocationModel *model in tableData) {
                                                                                cordinates.latitude = model.latitude;
                                                                                cordinates.longitude = model.longitude;
                                                                                
                                                                                [self setPokemonOnMap: cordinates pokemonName: model.pokedexId addPokemonTopMap: model == [tableData lastObject]];
                                                                            }
                                                                            
                                                                        } failure:^(NSError *error) {
                                                                            NSLog(@"%@", error);
                                                                        }];
        }
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (int)[tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    PGOLocationModel *model = [tableData objectAtIndex:(NSUInteger)indexPath.row] ? : nil;
    PGOLocationModel *lastModel = [tableData lastObject];
    
    if (model) {
//        CLLocationDistance distance = [[[CLLocation alloc] initWithLatitude: model.latitude longitude: model.longitude] distanceFromLocation: [[CLLocation alloc] initWithLatitude: self.location Manager.location.coordinate.latitude longitude: self.locationManager.location.coordinate.longitude]];
        
        CLLocationCoordinate2D cordinates;
        
        cordinates.latitude = model.latitude;
        cordinates.longitude = model.longitude;
        
//        cell.textLabel.text = [NSString stringWithFormat:@"%@, %d meters, %@, %@", [pokemonList getPokemonByID: model.pokedexId] ,(int)distance ,[self calculateUserAngle: cordinates], model.expTime];
    }
    
    return cell;
}

- (NSString *)calculateUserAngle:(CLLocationCoordinate2D)user {
    CLLocationDegrees locLat = self.locationManager.location.coordinate.latitude;
    CLLocationDegrees locLon = self.locationManager.location.coordinate.longitude;
    double degrees;
    
    NSLog(@"%f ; %f", locLat, locLon);
    
    if(locLat > user.latitude && locLon > user.longitude) {
        // north east
        degrees = 0;
    }
    else if(locLat > user.latitude && locLon < user.longitude) {
        // south east
        degrees = 45;
    }
    else if(locLat < user.latitude && locLon < user.longitude) {
        // south west
        degrees = 180;
    }
    else {
        // north west
        degrees = 225;
    }
    
    return [self windDirectionFromDegrees: degrees];
}

- (NSString *)windDirectionFromDegrees:(double)degrees
{
    static NSArray *directions;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Initialize array on first call.
        directions = @[@"N", @"NNE", @"NE", @"ENE", @"E", @"ESE", @"SE", @"SSE",
                       @"S", @"SSW", @"SW", @"WSW", @"W", @"WNW", @"NW", @"NNW"];
    });
    
    int i = (int)((degrees + 11.25)/22.5);
    return directions[i % 16];
}

- (MKAnnotationView *)mapView: (MKMapView *)mapView viewForAnnotation: (id<MKAnnotation>)annotation
{
    MKPointAnnotation *pin = annotation;
    
    if (annotation == self.mapView.userLocation || [pin.title isEqualToString: @"-1"]) {
        return nil;
    }
    
    static NSString *AnnotationViewID = @"annotationViewID";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    
    annotationView.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@.png", pin.title]];
    annotationView.annotation = annotation;
    
    return annotationView;
}


@end

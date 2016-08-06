//
//  PGOLocationRequestModel.m
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import "PGOLocationRequestModel.h"

@implementation PGOLocationRequestModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
                @"pokestops": @"pokestops",
                @"gyms": @"gyms",
                @"scan": @"scanned",
                @"latitude": @"swLat",
                @"longitude": @"swLng"
            };
}

- (BOOL)pokestops
{
    if (!_pokestops) {
        _pokestops = NO;
    }
    
    return _pokestops;
}

- (BOOL)gyms
{
    if (!_gyms) {
        _gyms = NO;
    }
    
    return _gyms;
}

- (BOOL)scan
{
    if (!_scan) {
        _scan = NO;
    }
    
    return _scan;
}

//- (NSString *)getLocation
//{
//    return [NSString stringWithFormat: @"%@/%@", self.latitude, self.longitude];
//}

@end

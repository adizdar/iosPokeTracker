//
//  PGOLocationRequestModel.h
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PGOLocationRequestModel : MTLModel <MTLJSONSerializing>

@property (nonatomic) BOOL pokestops;
@property (nonatomic) BOOL gyms;
@property (nonatomic) BOOL scan;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;

//- (NSString *)getLocation;

@end

//
//  PGOLocationResponseModel.h
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "PGOLocationModel.h"

@interface PGOLocationResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSMutableArray *pokemons;

@end

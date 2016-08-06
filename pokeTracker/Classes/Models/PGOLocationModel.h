//
//  PGOLocationModel.h
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PGOLocationModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *encounterId;
@property (nonatomic, copy) NSString *pokemonName;
@property (nonatomic, copy) NSString *spawnPointId;

@property double latitude;
@property double longitude;

@property NSInteger meters;
@property NSInteger pokedexId;
@property NSInteger disappearTime;

@end

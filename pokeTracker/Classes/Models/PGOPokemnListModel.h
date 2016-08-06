//
//  PGOPokemnListModel.h
//  pokeTracker
//
//  Created by Ahmed Dizdar on 21/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGOPokemnListModel : NSObject

@property (strong, nonatomic) NSDictionary *pokemonList;

- (NSString *)getPokemonByID: (int)pokdexID;

@end

//
//  PGOLocationResponseModel.m
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import "PGOLocationResponseModel.h"

@implementation PGOLocationResponseModel

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"pokemons" : @"pokemons"
            };
}

#pragma mark - JSON Transformer

+ (NSValueTransformer *)pokemonsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass: PGOLocationModel.class];
}

@end

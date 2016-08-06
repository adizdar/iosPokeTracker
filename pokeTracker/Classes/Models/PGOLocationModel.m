//
//  PGOLocationModel.m
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import "PGOLocationModel.h"
#import "PGOPokemnListModel.h"

@implementation PGOLocationModel

PGOPokemnListModel *pokemonList;    

- (instancetype)init
{
    self = [super init];
    
    if (!self) return nil;
    
    pokemonList = [PGOPokemnListModel new];
    
    return self;
}

#pragma mark - Mantle JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"pokedexId": @"pokemon_id",
             @"pokemonName": @"pokemon_name",
             @"encounterId": @"encounter_id",
             @"disappearTime": @"disappear_time",
             @"latitude": @"latitude",
             @"longitude": @"longitude"
//             @"spawnPointId": @"spawnpoint_id"
             };
}

#pragma mark - JSON Transformers

// ** Only to use if you want pokemon names inded of pokedex ID and CHANGE pokedexID to NSSTRING*
//+ (NSValueTransformer *)pokedexIdJSONTransformer
//{
//    return [MTLValueTransformer transformerUsingForwardBlock: ^id(NSString* value, BOOL *success, NSError *__autoreleasing *error) {
//        return [pokemonList getPokemonByID: [value integerValue]];
//    } reverseBlock: ^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        return value;
//    }];
//}

//+ (NSValueTransformer *)disappearTimeJSONTransformer
//{
//    return [MTLValueTransformer transformerUsingForwardBlock: ^id(NSString* value, BOOL *success, NSError *__autoreleasing *error) {
//        NSDate *dateTo = [NSDate dateWithTimeIntervalSince1970:[value integerValue]];
//        NSDate *dateNow = [NSDate date];
//        
//        NSTimeInterval secondsBetween = [dateTo timeIntervalSinceDate:dateNow];
//        NSString *newExpTime = [NSString stringWithFormat:@"%02li:%02li:%02li",
//                                lround(floor(secondsBetween / 3600.)) % 100,
//                                lround(floor(secondsBetween / 60.)) % 60,
//                                lround(floor(secondsBetween)) % 60];
//        
//        return newExpTime;
//        
//    } reverseBlock: ^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        return value;
//    }];
//}

@end

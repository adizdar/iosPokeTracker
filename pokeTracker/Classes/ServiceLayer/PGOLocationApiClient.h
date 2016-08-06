//
//  PGOLocationApiClient.h
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface PGOLocationApiClient : AFHTTPSessionManager

/** Singleton for retriving sharedManager
 @return id
 */
+ (id)sharedManager;

@end

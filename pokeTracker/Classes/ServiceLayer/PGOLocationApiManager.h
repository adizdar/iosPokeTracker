//
//  PGOLocationApiManager.h
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import "PGOLocationApiClient.h"
#import "PGOLocationRequestModel.h"
#import "PGOLocationResponseModel.h"

@interface PGOLocationApiManager : PGOLocationApiClient

- (NSURLSessionDataTask *) getLocationsWithRequestModel:(PGOLocationRequestModel *)requestModel
                                             success:(void (^)(PGOLocationResponseModel *responseModel))success
                                             failure:(void (^)(NSError *error))failure;

@end

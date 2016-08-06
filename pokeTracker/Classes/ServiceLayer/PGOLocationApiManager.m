//
//  PGOLocationApiManager.m
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import "PGOLocationApiManager.h"

@implementation PGOLocationApiManager

static NSString *const dataPath = @"/raw_data?";

- (NSURLSessionDataTask *) getLocationsWithRequestModel:(PGOLocationRequestModel *)requestModel
                                             success:(void (^)(PGOLocationResponseModel *responseModel))success
                                             failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
//    NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    return [self GET: dataPath parameters: parameters progress:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 
                 NSError *error;
                 NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                 
                 PGOLocationResponseModel *list = [MTLJSONAdapter modelOfClass:PGOLocationResponseModel.class
                                                            fromJSONDictionary:responseDictionary error:&error];
                 success(list);
                 
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 
                 failure(error);
                 
             }];
    
}
@end

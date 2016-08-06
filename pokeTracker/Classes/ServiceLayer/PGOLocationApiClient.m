//
//  PGOLocationApiClient.m
//  pokeTracker
//
//  Created by Ahmed Dizdar on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

#import "PGOLocationApiClient.h"

@implementation PGOLocationApiClient

static NSString* const BASE_URL = @"http://dattung.no-ip.org";

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super initWithBaseURL: [NSURL URLWithString: BASE_URL]];
    
    if (!self) return nil;
    
//    [self.requestSerializer setTimeoutInterval: 20.0];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return self;
}

#pragma mark - Custom Accessors

#pragma mark - Public

+ (id)sharedManager
{
    static PGOLocationApiClient *_sessionManager = nil;
    static dispatch_once_t onceToken;
    
    // initialize only once
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc] init];
    });
    
    return _sessionManager;
}



@end

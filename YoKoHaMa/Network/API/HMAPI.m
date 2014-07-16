//
//  HMAPI.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMAPI.h"

#import "HMNetwork.h"

@interface HMAPI ()

@property (nonatomic, readwrite, strong) AFHTTPRequestOperationManager * getManager;
@property (nonatomic, readwrite, strong) AFHTTPRequestOperationManager * postManager;

@property (nonatomic, strong) AFJSONResponseSerializer * jsonResponseSerializer;

@end


@implementation HMAPI


+ (instancetype) apiCenter
{
    static HMAPI * api = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[self alloc] init];
    });
    
    return api;
}


#pragma mark - Instance methods
@synthesize getManager = _getManager;
@synthesize postManager = _postManager;

- (id) init
{
    if (self = [super init]) {
        _getManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[HMNetwork sharedNetwork].baseURL];
        _postManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[HMNetwork sharedNetwork].adminURL];
        
        
        AFJSONResponseSerializer * jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        
        NSMutableSet * acceptableContentTypes = [[NSMutableSet alloc] initWithSet:jsonResponseSerializer.acceptableContentTypes];
        [acceptableContentTypes addObject:@"text/plain"];
        [acceptableContentTypes addObject:@"text/html"];
        
        [jsonResponseSerializer setAcceptableContentTypes:acceptableContentTypes];
        
        self.jsonResponseSerializer = jsonResponseSerializer;
    }
    
    return self;
}

#pragma mark -

- (RACSignal *)refreshFocusForCategory:(NSNumber *)catID
{
    RACSignal * signal = [RACSignal empty];
    
    if (catID)
    {
        _getManager.responseSerializer = self.jsonResponseSerializer;
        
        NSString * urlString = [[HMNetwork sharedNetwork].baseURL.absoluteString stringByAppendingPathComponent:@"/index.php"];
        
        signal = [_getManager rac_GET:urlString
                           parameters:(@{
                                         @"a" : @"shows",
                                         @"catid": catID,
                                         @"id": @1
                                         })];
    }
    
    return signal;
}

@end

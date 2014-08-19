#import "APIClient.h"
#import "ServerAddress.h"


@interface APIClient ()

@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;
@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

@end

@implementation APIClient


+ (instancetype)sharedInstance {
    
    static APIClient *_self;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _self = [[self alloc]init];
    });
    
    
    return _self;
    
}


- (id)init {
    self = [super init];
    
    if (self){
        
        _requestManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
        _requestManager.requestSerializer = [AFJSONRequestSerializer serializer];

        
        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
        [serializer setRemovesKeysWithNullValues:YES];
        _requestManager.responseSerializer = serializer;
        _requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

//        _requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];

        [self addDefaultHeaders];
        
        
        //reachability
        _reachabilityManager = [[AFNetworkReachabilityManager  alloc]init];
        [_reachabilityManager startMonitoring];
        
        
    }
    
    return self;
}

#pragma mark - Public Methods

- (AFNetworkReachabilityStatus)networkReachabilityStatus {
    
    return [self.reachabilityManager networkReachabilityStatus];
}

- (void)postScanCodeReportWithPublicPartnerID:(NSString*)productPartnerID
                             productInstance:(NSString *)productInstance
                                   segmentID:(NSString *)segmentID
                                  completion:(CompletionBlock)complete
                                     failure:(FailureBlock)failure {
    
    [self postPath:[self fullPathForRequest:@"jsontest"]
       parameters:@{@"PublicPartnerID":@1,
                    @"ProductInstance":@1,
                    @"SegmentID":@1,
                    @"ClientTimeStamp":@"f",
                    @"ClientGeolocation":@"f"
                    }
     authRequired:NO
          success:complete
          failure:failure];
}




#pragma mark - Base HTTP Methods





- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
   authRequired:(BOOL)authRequired
        success:(CompletionBlock)success
        failure:(FailureBlock)failure  {
    
    
    
    AFHTTPRequestOperation *request = [self.requestManager GET:path
                                                    parameters:parameters
                                                       success: [self successBlock:success failure:failure]
                                                       failure:[self failureBlock:failure]];
    
    
    
    [request start];
    
}


- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
    authRequired:(BOOL)authRequired
         success:(CompletionBlock)success
         failure:(FailureBlock)failure {
    
    AFHTTPRequestOperation *request = [self.requestManager POST:path
                   parameters:parameters
                      success: [self successBlock:success failure:failure]
                      failure:[self failureBlock:failure]];
    
    
   NSLog(@"%@",request);
    
    
    
    
}





- (void)putPath:(NSString *)path
     parameters:(NSDictionary *)parameters
   authRequired:(BOOL)authRequired
        success:(CompletionBlock)success
        failure:(FailureBlock)failure  {
    
    AFHTTPRequestOperation *request = [self.requestManager PUT:path
                                                    parameters:parameters
                                                       success: [self successBlock:success failure:failure]
                                                       failure:[self failureBlock:failure]];
    
    
    
    
    [request start];
    
    
    
    
    
}

- (void)deletePath:(NSString *)path
      authRequired:(BOOL)authRequired
           success:(CompletionBlock)success
           failure:(FailureBlock)failure  {
    
    
    
    AFHTTPRequestOperation *request = [self.requestManager DELETE:path
                                                       parameters:nil
                                                          success: [self successBlock:success failure:failure]
                                                          failure:[self failureBlock:failure]];
    
    
    
    
    
    [request start];
    
    
}

#pragma mark - Private


- (void)addDefaultHeaders {
    
//    AFHTTPRequestSerializer *serializer = self.requestManager.requestSerializer;
//
//    [serializer setValue:[[UIDevice currentDevice]model] forHTTPHeaderField:@"device"];
//    [serializer setValue:[[UIDevice currentDevice]systemVersion] forHTTPHeaderField:@"os_version"];
//    [serializer setValue:@"iOS" forHTTPHeaderField:@"OS"];
//    
//    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//    NSString *appVersion = [infoDict objectForKey:@"CFBundleShortVersionString"]; // example: 1.0.0
//    
//    [serializer setValue:appVersion forHTTPHeaderField:@"app_version"];
    
    
}

/// Factory method for completion methods. If the server doesn't return success, then call failure.
- (void (^)(AFHTTPRequestOperation *operation, id results)) successBlock:(CompletionBlock)success failure:(FailureBlock)failure {
    
    
    
    void (^complete)(AFHTTPRequestOperation *operation, id results)  =  ^(AFHTTPRequestOperation *operation, NSDictionary *results){
        
        
        NSLog(@"URL: %@ results: %@", [operation.request.URL absoluteString],[results description]);
        
//        NSDictionary *meta = results[@"meta"];
//        
//        NSInteger code = 0;
//        
//        if (meta[@"code"]) {
//            code = [meta[@"code"]integerValue];
//        }
//        
//        
//        if (code/200 != 1 ) {
//            
//            NSError *error =  [NSError errorWithDomain:@"" code:code userInfo:meta];
//            
//            if (failure) failure(error);
//            
//        } else {
//            
            if (success) success(results);
//        }
        
    };
    
    
    
    return complete;
    
}



///Factory Method for failure block.
- (void(^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock:(FailureBlock)failure {
    
    return ^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        TFLog(@"URL: %@ failure: %@", [operation.request.URL absoluteString],[error description]);
        
        if (failure) failure(error);
    };
}


- (NSString*)fullPathForRequest:(NSString*)partialPath {
    
    return [NSString stringWithFormat:@"%@%@",kAPIBaseURLString,partialPath];
    
}



@end

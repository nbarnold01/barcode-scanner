#import "Barcode_ScannerAPIClient.h"


@interface Barcode_ScannerAPIClient ()

@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;
@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

@end

@implementation Barcode_ScannerAPIClient


+ (instancetype)sharedInstance {
    
    static Barcode_ScannerAPIClient *_self;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _self = [[super alloc]init];
    });
    
    
    return _self;
    
}


- (id)init {
    self = [super init];
    
    if (self){
        
        _requestManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
        
        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
        [serializer setRemovesKeysWithNullValues:YES];
        _requestManager.responseSerializer = serializer;
        
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




#pragma mark - Base HTTP Methods





- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
   authRequired:(BOOL)authRequired
        success:(BLCompletionBlock)success
        failure:(BLFailureBlock)failure  {
    
    
    
    AFHTTPRequestOperation *request = [self.requestManager GET:path
                                                    parameters:parameters
                                                       success: [self successBlock:success failure:failure]
                                                       failure:[self failureBlock:failure]];
    
    
    
    [request start];
    
}


- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
    authRequired:(BOOL)authRequired
         success:(BLCompletionBlock)success
         failure:(BLFailureBlock)failure {
    
    AFHTTPRequestOperation *request = [self.requestManager POST:path
                                                     parameters:parameters
                                                        success: [self successBlock:success failure:failure]
                                                        failure:[self failureBlock:failure]];
    
    [request start];
    
}





- (void)putPath:(NSString *)path
     parameters:(NSDictionary *)parameters
   authRequired:(BOOL)authRequired
        success:(BLCompletionBlock)success
        failure:(BLFailureBlock)failure  {
    
    AFHTTPRequestOperation *request = [self.requestManager PUT:path
                                                    parameters:parameters
                                                       success: [self successBlock:success failure:failure]
                                                       failure:[self failureBlock:failure]];
    
    
    
    
    [request start];
    
    
    
    
    
}

- (void)deletePath:(NSString *)path
      authRequired:(BOOL)authRequired
           success:(BLCompletionBlock)success
           failure:(BLFailureBlock)failure  {
    
    
    
    AFHTTPRequestOperation *request = [self.requestManager DELETE:path
                                                       parameters:nil
                                                          success: [self successBlock:success failure:failure]
                                                          failure:[self failureBlock:failure]];
    
    
    
    
    
    [request start];
    
    
}

#pragma mark - Private


- (void)addDefaultHeaders {
    
    AFHTTPRequestSerializer *serializer = self.requestManager.requestSerializer;
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
- (void (^)(AFHTTPRequestOperation *operation, id results)) successBlock:(BLCompletionBlock)success failure:(BLFailureBlock)failure {
    
    
    
    void (^complete)(AFHTTPRequestOperation *operation, id results)  =  ^(AFHTTPRequestOperation *operation, NSDictionary *results){
        
        
        NSLog(@"URL: %@ results: %@", [operation.request.URL absoluteString],[results description]);
        
        NSDictionary *meta = results[@"meta"];
        
        NSInteger code = 0;
        
        if (meta[@"code"]) {
            code = [meta[@"code"]integerValue];
        }
        
        
        if (code/200 != 1 ) {
            
            NSError *error =  [NSError errorWithDomain:@"" code:code userInfo:meta];
            
            if (failure) failure(error);
            
        } else {
            
            if (success) success(results);
        }
        
    };
    
    
    
    return complete;
    
}



///Factory Method for failure block.
- (void(^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock:(BLFailureBlock)failure {
    
    return ^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        TFLog(@"URL: %@ failure: %@", [operation.request.URL absoluteString],[error description]);
        
        if (failure) failure(error);
    };
}


- (NSString*)fullPathForRequest:(NSString*)partialPath {
    
    return [NSString stringWithFormat:@"%@%@",kAPIBaseURLString,partialPath];
    
}



@end
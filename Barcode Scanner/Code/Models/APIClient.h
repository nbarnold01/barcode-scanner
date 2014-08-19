#import <AFNetworking/AFHTTPRequestOperationManager.h>



typedef void (^CompletionBlock)(id items);
typedef void (^FailureBlock)(NSError *error);


@interface APIClient : NSObject

+ (APIClient *)sharedInstance;

- (AFNetworkReachabilityStatus)networkReachabilityStatus;

- (void)postScanCodeReportWithPublicPartnerID:(NSString*)productPartnerID
                             productInstance:(NSString *)productInstance
                                   segmentID:(NSString *)segmentID
                                  completion:(CompletionBlock)complete
                                     failure:(FailureBlock)failure;

@end

#import <AFNetworking/AFHTTPRequestOperationManager.h>


static NSString * const kAPIBaseURLString = @"https://example.com/api/v1/";

typedef void (^CompletionBlock)(id items);
typedef void (^FailureBlock)(NSError *error);


@interface APIClient : NSObject

+ (APIClient *)sharedInstance;

- (AFNetworkReachabilityStatus)networkReachabilityStatus;

- (void)getScanCodeReportWithPublicPartnerID:(NSString*)productPartnerID
                             productInstance:(NSString *)productInstance
                                   segmentID:(NSString *)segmentID
                                  completion:(CompletionBlock)complete
                                     failure:(FailureBlock)failure;

@end

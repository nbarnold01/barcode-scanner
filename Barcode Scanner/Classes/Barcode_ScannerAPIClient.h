#import <AFNetworking/AFHTTPRequestOperationManager.h>


static NSString * const kAPIBaseURLString = @"https://example.com/api/v1/";

typedef void (^CompletionBlock)(id items);
typedef void (^FailureBlock)(NSError *error);


@interface Barcode_ScannerAPIClient : NSObject

+ (Barcode_ScannerAPIClient *)sharedInstance;

@end

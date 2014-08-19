//
//  ScanResultViewController.m
//  Barcode Scanner
//
//  Created by Nathan Arnold on 8/13/14.
//  Copyright (c) 2014 Nathan Arnold. All rights reserved.
//

#import "ScanResultViewController.h"
#import "APIClient.h"
#import "ServerAddress.h"

@interface ScanResultViewController ()

@property (nonatomic, strong) NSString *publicPartnerID;
@property (nonatomic, strong) NSString *productInstance;
@property (nonatomic, strong) NSString *segmentId;

@end

@implementation ScanResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.scanCodeTextView.text = self.code;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (IBAction)pressedSubmit:(id)sender {
    
    [self sendToServer];
    
}

#pragma mark - Private

- (void)parseCode {

}

- (void)sendToServer {
    
//    
//   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kAPIBaseURLString,@"jsontest"]]];
//    
//    
//    [request setHTTPMethod:@"POST"];
//    
//    return;
    
    [[APIClient sharedInstance]postScanCodeReportWithPublicPartnerID:self.productInstanceLabel.text
                                                    productInstance:self.productInstanceLabel.text
                                                          segmentID:self.segmentIDLabel.text
                                                         completion:^(id items) {
                                                             NSLog(@"items: %@",items);
                                                             
                                                         } failure:^(NSError *error) {
                                                             NSLog(@"%@",error);
                                                         }];
    
}

@end

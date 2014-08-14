//
//  ScanResultViewController.m
//  Barcode Scanner
//
//  Created by Nathan Arnold on 8/13/14.
//  Copyright (c) 2014 Nathan Arnold. All rights reserved.
//

#import "ScanResultViewController.h"
#import "APIClient.h"

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

- (IBAction)resubmitPressed:(id)sender {
    
    self.code = self.scanCodeTextView.text;

    [self sendToServer];
    
}

#pragma mark - Private

- (void)parseCode {

}

- (void)sendToServer {
    
//    [APIClient sharedInstance]getScanCodeReportWithPublicPartnerID:<#(NSString *)#> productInstance:<#(NSString *)#> segmentID:<#(NSString *)#> completion:<#^(id items)complete#> failure:<#^(NSError *error)failure#>
    
}

@end

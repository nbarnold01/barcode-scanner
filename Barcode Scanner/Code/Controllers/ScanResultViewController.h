//
//  ScanResultViewController.h
//  Barcode Scanner
//
//  Created by Nathan Arnold on 8/13/14.
//  Copyright (c) 2014 Nathan Arnold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultViewController : UITableViewController

@property (nonatomic, strong) NSString *code;

@property (weak, nonatomic) IBOutlet UITextView *scanCodeTextView;

@property (weak, nonatomic) IBOutlet UITextView *serverResponseTextView;
@property (weak, nonatomic) IBOutlet UITextField *partnerIDLabel;
@property (weak, nonatomic) IBOutlet UITextField *productInstanceLabel;
@property (weak, nonatomic) IBOutlet UITextField *segmentIDLabel;

- (IBAction)pressedSubmit:(id)sender;


@end

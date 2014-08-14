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

- (IBAction)resubmitPressed:(id)sender;



@end

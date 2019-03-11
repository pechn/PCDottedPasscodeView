//
//  PCViewController.m
//  PCDottedPasscodeView
//
//  Created by Peter Chen on 05/30/2018.
//  Copyright (c) 2018 Peter Chen. All rights reserved.
//

#import "PCViewController.h"

@interface PCViewController ()

@end

@implementation PCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewPasscode.passcodeCompleted = ^(NSString *passcode) {
        NSLog(@"passcode input: %@", passcode);
        [self.viewPasscode clearInputs];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.viewPasscode.textField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.viewPasscode.textField resignFirstResponder];
}

@end

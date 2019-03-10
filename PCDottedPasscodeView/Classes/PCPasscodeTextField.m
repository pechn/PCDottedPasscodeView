//
//  PCPasscodeTextField.m
//  PCDottedPasscodeView
//
//  Created by Peter Chen on 05/30/2018.
//  Copyright (c) 2018 Peter Chen. All rights reserved.
//

#import "PCPasscodeTextField.h"

@implementation PCPasscodeTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

// hide the cursor
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    return CGRectZero;
}

@end

//
//  PCDottedPasscodeView.h
//  PCDottedPasscodeView
//
//  Created by Peter Chen on 05/30/2018.
//  Copyright (c) 2018 Peter Chen. All rights reserved.
//

#import "PCPasscodeTextField.h"

IB_DESIGNABLE
NS_ASSUME_NONNULL_BEGIN
@interface PCDottedPasscodeView : UIView<UITextFieldDelegate>

@property(nonatomic, strong) PCPasscodeTextField *textField;

- (id)initWithFrame:(CGRect)frame dotColor:(UIColor *)dotColor;

@property(nonatomic, strong) IBInspectable UIColor *dotColor;
@property(nonatomic, assign) IBInspectable NSUInteger dotCount;
@property(nonatomic, assign) IBInspectable CGFloat dotWidth;

@property(nonatomic, copy) void (^passcodeCompleted)(NSString *passcode);

- (void)clearInputs;

@end
NS_ASSUME_NONNULL_END

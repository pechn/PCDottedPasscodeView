//
//  PCDottedPasscodeView.m
//  PCDottedPasscodeView
//
//  Created by Peter Chen on 05/30/2018.
//  Copyright (c) 2018 Peter Chen. All rights reserved.
//

#import "PCDottedPasscodeView.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kDotCountDefault 6
#define kDotWidthDefault 14.f
#define kFieldHeightDefault 45.f

@interface PCDottedPasscodeView ()

@property(nonatomic, strong) NSMutableArray *dotArray;
@property(nonatomic, assign) CGRect previousFrame;

@end

@implementation PCDottedPasscodeView

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame dotColor:[UIColor blackColor]];
}

// for storyboard initialization
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [self init];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame dotColor:(UIColor *)dotColor {
    self = [super initWithFrame:frame];
    if (self) {
        _previousFrame = frame;
        _dotColor = dotColor;
        _dotCount = kDotCountDefault;
        _dotWidth = kDotWidthDefault;
        _dotArray = [NSMutableArray array];
        [self initView];
    }
    
    return self;
}

// This method is called each time the view's frame is changed.
// So it's important to layout the subviews here expecially when autolayout is applied!!
- (void)layoutSubviews {
    if (_previousFrame.size.width != self.frame.size.width) {
        _previousFrame = self.frame;
        [self updateTextFieldFrame];
        [self updateDotViewFrame];
    }
}

- (void)initView {
    self.clipsToBounds = YES;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.textField];
    
    /**
     * Best Practices - not to let textField become first responder here as it may cause some weird behaviors
     * You should call becomeFirstResponder in the view controller's viewDidApear() callback method as below:
     * [self.[PCDottedPasscodeView object].textField becomeFirstResponder];
     * And then resign the first responder in viewWillDisappear():
     * [self.[PCDottedPasscodeView object].textField resignFirstResponder];
     */
    
    // [self.textField becomeFirstResponder];
    
    [self initDotView];
}

- (void)setDotColor:(UIColor *)dotColor {
    _dotColor = dotColor;
    
    for (UIView *dotView in self.dotArray) {
        dotView.layer.borderColor = [dotColor CGColor];
    }
}

- (void)setDotCount:(NSUInteger)dotCount {
    _dotCount = dotCount;
    [self initDotView];
}

- (void)setDotWidth:(CGFloat)dotWidth {
    _dotWidth = dotWidth;
    [self initDotView];
}

- (void)initDotView {
    // remove all the dot views first
    for (UIView *view in self.subviews) {
        if (![view isKindOfClass:[UITextField class]]) {
            [view removeFromSuperview];
        }
    }
    
    [self.dotArray removeAllObjects];
    
    CGFloat dotAreaWidth = self.frame.size.width / self.dotCount;
    
    for (int i = 0; i < self.dotCount; i++) {
        CGFloat dotX = (dotAreaWidth - self.dotWidth) / 2.f + i * dotAreaWidth;
        CGFloat dotY = (self.frame.size.height - self.dotWidth) / 2.f;
        // UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(dotX, dotY, self.dotWidth, self.dotWidth)];
        UIView *dotView = [[UIView alloc] init];
        dotView.translatesAutoresizingMaskIntoConstraints = NO;
        dotView.frame = CGRectMake(dotX, dotY, self.dotWidth, self.dotWidth);
        dotView.backgroundColor = [UIColor clearColor];
        dotView.layer.cornerRadius = self.dotWidth / 2.f;
        dotView.layer.borderColor = [self.dotColor CGColor];
        dotView.layer.borderWidth = 2.f;
        dotView.layer.masksToBounds = YES;
        
        // make the circle edge more smooth
        dotView.layer.shouldRasterize = YES;
        dotView.layer.rasterizationScale = 3.0 * [UIScreen mainScreen].scale;
        
        dotView.clipsToBounds = YES;
        [self addSubview:dotView];
        
        [self.dotArray addObject:dotView];
    }
}

- (void)updateTextFieldFrame {
    self.textField.frame = CGRectMake(0, 0, self.frame.size.width, kFieldHeightDefault);
}

- (void)updateDotViewFrame {
    CGFloat dotAreaWidth = self.frame.size.width / self.dotCount;
    for (int i = 0; i < self.dotCount; i++) {
        CGFloat dotX = (dotAreaWidth - self.dotWidth) / 2.f + i * dotAreaWidth;
        CGFloat dotY = (self.frame.size.height - self.dotWidth) / 2.f;
        UIView *dotView = self.dotArray[i];
        dotView.frame = CGRectMake(dotX, dotY, self.dotWidth, self.dotWidth);
    }
}

- (PCPasscodeTextField *)textField {
    if (!_textField) {
        // _textField = [[PCPasscodeTextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kFieldHeightDefault)];
        _textField = [[PCPasscodeTextField alloc] init];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        _textField.frame = CGRectMake(0, 0, self.frame.size.width, kFieldHeightDefault);
        // _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.tintColor = [UIColor clearColor];
        _textField.textColor = [UIColor clearColor];
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = (id)self;
        
        [_textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _textField;
}

- (void)textFieldDidChanged:(UITextField *)textField {
    for (int i = 0; i < self.dotCount; i++) {
        UIView *dotView = (UIView *)self.dotArray[i];
        if (i < textField.text.length) {
            dotView.backgroundColor = self.dotColor;
        } else {
            dotView.backgroundColor = [UIColor clearColor];
        }
    }
    
    if (textField.text.length == self.dotCount) {
        self.passcodeCompleted ? self.passcodeCompleted(textField.text) : NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        return NO;
    } else if (string.length == 0) {
        return YES;
    } else if (textField.text.length >= self.dotCount) {
        return NO;
    } else {
        return YES;
    }
}

- (void)clearInputs {
    self.textField.text = @"";
    [self textFieldDidChanged:self.textField];
}

@end

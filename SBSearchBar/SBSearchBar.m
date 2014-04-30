//
//  SBSearchBar.m
//  SBSearchBarExample
//
//  Created by Santiago Bustamante on 4/29/14.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#import "SBSearchBar.h"

@implementation SBSearchBar
{
    UIColor *textColor;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.searchTextField = [[UITextField alloc] initWithFrame:self.frame];
        self.searchTextField.placeholder = NSLocalizedString(@"Search", nil);
        self.lensImageView = [[UIImageView alloc] init];
    }
    return self;
}


- (void) willMoveToSuperview:(UIView *)newSuperview{
    
    self.searchTextField.delegate = self;
    self.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.searchTextField setReturnKeyType:UIReturnKeySearch];
    [self addSubview:self.searchTextField];
    [self.searchTextField setTextColor:textColor];
    
    CGRect frame = self.searchTextField.frame;
    frame.origin = CGPointZero;
    frame.origin.x = CGRectGetWidth(self.lensImageView.frame) + 6;
    frame.size.width = CGRectGetWidth(self.frame) - CGRectGetWidth(self.lensImageView.frame) + 6;
    self.searchTextField.frame = frame;
    
    
    [self addSubview:self.lensImageView];
    
    frame = self.lensImageView.frame;
    frame.origin.x = 3;//CGRectGetWidth(self.frame)/2 - CGRectGetWidth(frame)/2;
    frame.origin.y = CGRectGetHeight(self.frame)/2 - CGRectGetHeight(frame)/2;
    self.lensImageView.frame = frame;
    

    
}

- (void) setLensImage:(UIImage *)lensImage{
    _lensImage = lensImage;
    [self.lensImageView removeFromSuperview];
    self.lensImageView = [[UIImageView alloc] initWithImage:_lensImage];
    [self addSubview:self.lensImageView];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    CGRect frame = self.lensImageView.frame;
    frame.origin.x = 3;
    [UIView animateWithDuration:0.1 animations:^{
        self.lensImageView.frame = frame;
    }];

    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField.text.length <= 0) {
        CGRect frame = self.lensImageView.frame;
        frame.origin.x = 3;//CGRectGetWidth(self.frame)/2 - CGRectGetWidth(frame)/2;

        [UIView animateWithDuration:0.1 animations:^{
            self.lensImageView.frame = frame;
        }];

    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarSearchButtonClicked:)]) {
        [self.delegate SBSearchBarSearchButtonClicked:self];
    }else{
        [self.searchTextField resignFirstResponder];
    }
    
    return YES;
}


-(NSString *) text{
    return self.searchTextField.text;
}

- (BOOL) resignFirstResponder{
    return [self.searchTextField resignFirstResponder];
}

-(void) setFont:(UIFont *)font{
    _font = font;
    [self.searchTextField setFont:font];
}

//- (UIFont *)font{
//    return self.searchTextField.font;
//}

-(void) setTextColor:(UIColor *)color{
    textColor = color;
    if (self.searchTextField.superview) {
      [self.searchTextField setTextColor:color];
    }
}

- (void) setPlaceHolderColor:(UIColor *)color{
    _placeHolderColor = color;
    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchTextField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
}

@end

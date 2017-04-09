//
//  SBSearchBar.m
//  SBSearchBarExample
//
//  Created by Santiago Bustamante on 4/29/14.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#import "SBSearchBar.h"

@interface SBSearchBar()
    @property (nonatomic, weak) IBOutlet NSLayoutConstraint *containerRightConstraint;
    @property (nonatomic, weak) IBOutlet NSLayoutConstraint *extraCancelWConstraint;
    @property (nonatomic, weak) IBOutlet NSLayoutConstraint *textfieldRightConstraint;
    @property (nonatomic, strong) SBSearchBar * _Nonnull view;
    @property (nonatomic, assign) CGRect orginalFrame;
    
    @end

@implementation SBSearchBar
    
    - (instancetype)initWithCoder:(NSCoder *)coder
    {
        self = [super initWithCoder:coder];
        if (self) {
            [self xibSetup];
        }
        return self;
    }
    
- (instancetype)initWithFrame:(CGRect)frame
    {
        self = [super initWithFrame:frame];
        if (self) {
            [self xibSetup];
        }
        return self;
    }
    
- (void) xibSetup
    {
        UINib *nib = [UINib nibWithNibName:@"SBSearchBar" bundle: [NSBundle bundleForClass:[self class]]];
        self.view = [nib instantiateWithOwner:self options:nil].firstObject;
        self.view.frame = [self bounds];
        [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        [self addSubview:self.view];
        self.placeHolderStr = NSLocalizedString(@"Search", nil);
        self.orginalFrame = [self bounds];
    }
    
- (void) willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    self.searchTextField.delegate = self;
    self.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.searchTextField setReturnKeyType:UIReturnKeySearch];
    [self.searchTextField setTextColor:self.textColor];
    
    if (!self.cancelButtonImage) {
        self.textfieldRightConstraint.constant = - self.cancelButton.frame.size.width;
    }
    
}
    
    -(void)didMoveToSuperview {
        
        
        if (self.placeHolderColor) {
            self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeHolderStr attributes:@{NSForegroundColorAttributeName: self.placeHolderColor}];
        }else{
            self.searchTextField.placeholder = self.placeHolderStr;
        }
        
    }
    
    - (void)setAddExtraCancelButton:(BOOL)addExtraCancelButton {
        _addExtraCancelButton = addExtraCancelButton;
        if (self.addExtraCancelButton) {
            if ([self.extraCancelButton.titleLabel.text isEqualToString:@"Button"]) {
                [self.extraCancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
            }
            
            [self.extraCancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        }
//        self.extraCancelButton.hidden = YES;
        [self hideExtraCancel];
    }
    
- (void) setLensImage:(UIImage *)lensImage{
    _lensImage = lensImage;
    self.lensImageView.image = self.lensImage;
}
    
-(void) setCancelButtonImage:(UIImage *)cancelButtonImage{
    _cancelButtonImage = cancelButtonImage;
    [self.cancelButton setBackgroundImage:_cancelButtonImage forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.hidden = true;
}
    
    
-(void) showExtraCancel{
    if (!self.addExtraCancelButton || !self.extraCancelButton.hidden) {
        return;
    }
    
    self.extraCancelButton.hidden = NO;
    CGRect frame = self.searchFieldsContainerView.frame;
    frame.size.width -= 80;
    
    CGRect frame2 = self.extraCancelButton.frame;
    frame2.size.width = 60;
    frame2.origin.x -= 60;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.searchFieldsContainerView.frame = frame;
        self.extraCancelButton.frame = frame2;
        
    } completion:^(BOOL finished) {
        self.extraCancelWConstraint.constant = 60;
        self.containerRightConstraint.constant = 10;
        [self.superview layoutIfNeeded];
    }];
}
    
-(void) hideExtraCancel{
    if (!self.addExtraCancelButton) {
        return;
    }
    
    CGRect frame = self.searchFieldsContainerView.frame;
    frame.size.width += 80;
    
    CGRect frame2 = self.extraCancelButton.frame;
    frame2.size.width = 0;
    frame2.origin.x += 60;
    [UIView animateWithDuration:0.2 animations:^{
        self.searchFieldsContainerView.frame = frame;
        self.extraCancelButton.frame = frame2;
    } completion:^(BOOL finished) {
        self.extraCancelWConstraint.constant = 0;
        self.containerRightConstraint.constant = -10;
        self.extraCancelButton.hidden = YES;
        [self.superview layoutIfNeeded];
    }];
}
    
    
    
    //UITextFieldDelegate
    
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [self showExtraCancel];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarShouldBeginEditing:)]) {
        [self.delegate SBSearchBarShouldBeginEditing:self];
    }
    
    return YES;
}
    
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarTextDidBeginEditing:)]) {
        [self.delegate SBSearchBarTextDidBeginEditing:self];
    }
}
    
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (newString.length > 0){
        self.cancelButton.hidden = false;
    }else{
        self.cancelButton.hidden = true;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarTextDidChange:text:)]){
        [self.delegate SBSearchBarTextDidChange:self text:newString];
    }
    
    return YES;
}
    
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField.text.length <= 0) {
        [self hideExtraCancel];
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarShouldEndEditing:)]) {
        [self.delegate SBSearchBarShouldEndEditing:self];
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
    
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarTextDidEndEditing:)]) {
        [self.delegate SBSearchBarTextDidEndEditing:self];
    }
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
    _textColor = color;
    if (self.searchTextField.superview) {
        [self.searchTextField setTextColor:color];
    }
}
    
- (void) setPlaceHolderColor:(UIColor *)color{
    _placeHolderColor = color;
    
    if (self.searchTextField) {
        self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeHolderStr attributes:@{NSForegroundColorAttributeName: color}];
    }
    
}
    
- (void) cancelAction:(id) sender{
    self.searchTextField.text = @"";
    self.cancelButton.hidden = YES;
    if (!self.searchTextField.isFirstResponder) {
        [self hideExtraCancel];
    }
    [self resignFirstResponder];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarCancelButtonClicked:)]) {
        [self.delegate SBSearchBarCancelButtonClicked:self];
    }
}
    
    
    @end

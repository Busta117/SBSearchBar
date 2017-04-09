//
//  SBSearchBar.h
//  SBSearchBarExample
//
//  Created by Santiago Bustamante on 4/29/14.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBSearchBar;

@protocol SBSearchBarDelegate <NSObject>
    
    @optional
- (void)SBSearchBarSearchButtonClicked:(SBSearchBar * _Nonnull)searchBar;                     // called when keyboard search button pressed
- (void)SBSearchBarCancelButtonClicked:(SBSearchBar * _Nonnull)searchBar;                     // called when cancel button is pressed
    
- (BOOL)SBSearchBarShouldBeginEditing:(SBSearchBar * _Nonnull)searchBar;                      // return NO to not become first responder
- (void)SBSearchBarTextDidBeginEditing:(SBSearchBar * _Nonnull)searchBar;                     // called when text starts editing
- (BOOL)SBSearchBarShouldEndEditing:(SBSearchBar * _Nonnull)searchBar;                        // return NO to not resign first responder
- (void)SBSearchBarTextDidEndEditing:(SBSearchBar * _Nonnull)searchBar;                       // called when text ends editing
    
- (void)SBSearchBarTextDidChange:(SBSearchBar * _Nonnull)searchBar text:(NSString * _Nonnull)searchText;                       // called when text did change
    
    @end

IB_DESIGNABLE

@interface SBSearchBar : UIView <UITextFieldDelegate>
    
    @property (nonatomic, weak) IBOutlet UIImageView * _Nullable lensImageView;
    @property (nonatomic, strong) IBInspectable UIImage * _Nullable lensImage;
    @property (nonatomic, weak) IBOutlet UIButton * _Nullable cancelButton;
    @property (nonatomic, strong) UIImage * _Nullable cancelButtonImage;
    @property (nonatomic, weak) IBOutlet UITextField * _Nullable searchTextField;
    @property (nonatomic, assign) IBInspectable id <SBSearchBarDelegate> _Nullable delegate;
    @property (nonatomic, readonly) NSString * _Nonnull text;
    @property (nonatomic, assign) UIFont * _Nullable font;
    @property (nonatomic, assign) UIColor * _Nullable placeHolderColor;
    
    @property (nonatomic, weak) IBOutlet UIView * _Nullable searchFieldsContainerView;
    @property (nonatomic, assign) IBInspectable BOOL addExtraCancelButton;
    @property (nonatomic, weak) IBOutlet UIButton * _Nullable extraCancelButton;
    
    @property (nonatomic, strong) NSString * _Nullable placeHolderStr;
    @property (nonatomic, strong) IBInspectable UIColor * _Nullable textColor;
    
    @end

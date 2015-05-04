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
- (void)SBSearchBarSearchButtonClicked:(SBSearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)SBSearchBarCancelButtonClicked:(SBSearchBar *)searchBar;                     // called when cancel button is pressed

- (BOOL)SBSearchBarShouldBeginEditing:(SBSearchBar *)searchBar;                      // return NO to not become first responder
- (void)SBSearchBarTextDidBeginEditing:(SBSearchBar *)searchBar;                     // called when text starts editing
- (BOOL)SBSearchBarShouldEndEditing:(SBSearchBar *)searchBar;                        // return NO to not resign first responder
- (void)SBSearchBarTextDidEndEditing:(SBSearchBar *)searchBar;                       // called when text ends editing

- (void)SBSearchBarTextDidChange:(SBSearchBar *)searchBar text:(NSString *)searchText;                       // called when text did change

@end

@interface SBSearchBar : UIView <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *lensImageView;
@property (nonatomic, strong) UIImage *lensImage;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) UIImage *cancelButtonImage;
@property (nonatomic, weak) IBOutlet UITextField *searchTextField;
@property (nonatomic, assign) id <SBSearchBarDelegate> delegate;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, assign) UIFont *font;
@property (nonatomic, assign) UIColor *placeHolderColor;

@property (nonatomic, weak) IBOutlet UIView *searchFieldsContainerView;
@property (nonatomic, assign) BOOL addExtraCancelButton;
@property (nonatomic, weak) IBOutlet UIButton *extraCancelButton;

-(void) setTextColor:(UIColor *)color;

@end

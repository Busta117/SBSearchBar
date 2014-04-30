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

@end

@interface SBSearchBar : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *lensImageView;
@property (nonatomic, strong) UIImage *lensImage;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, assign) id <SBSearchBarDelegate> delegate;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, assign) UIFont *font;
@property (nonatomic, assign) UIColor *placeHolderColor;

-(void) setTextColor:(UIColor *)color;

@end

//
//  SBExampleViewController.m
//  SBSearchBarExample
//
//  Created by Santiago Bustamante on 4/30/14.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#import "SBExampleViewController.h"


@interface SBExampleViewController ()

@end

@implementation SBExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    SBSearchBar *searchBarCustom = [[SBSearchBar alloc] initWithFrame:CGRectMake(10, 100, UIScreen.mainScreen.bounds.size.width - 20, 40)];
    [searchBarCustom setTextColor:[UIColor blackColor]];
    searchBarCustom.placeHolderColor = [UIColor darkGrayColor];
    searchBarCustom.font = [UIFont fontWithName:@"Arial" size:14];
    searchBarCustom.delegate = self;
    searchBarCustom.lensImage = [UIImage imageNamed:@"ic_lens"];
    searchBarCustom.cancelButtonImage = [UIImage imageNamed:@"FormReset"];

    searchBarCustom.addExtraCancelButton = YES; //new cancel button

    //custom
    searchBarCustom.searchFieldsContainerView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
    searchBarCustom.extraCancelButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    searchBarCustom.extraCancelButton.layer.borderWidth = 1;
    searchBarCustom.extraCancelButton.layer.borderColor = [UIColor blackColor].CGColor;
    searchBarCustom.placeHolderStr = @"customSearchBar";
    [self.view addSubview:searchBarCustom];
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

SBSearchBar
===========

Easy custom searchBar

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SBPickerSelector in your projects.

#### Podfile

```ruby
pod 'SBSearchBar'
```

### Installation without CocoaPods
- import in your project the folder "SBSearchBar"

###How to use

- in your code import SBSearchBar.h
```objective-c
#import "SBSearchBar.h"
```
- implement delegate in your class
```objective-c
@interface className : UIViewController <SBSearchBarDelegate>
```
- add delegate methods
```objective-c
- (void)SBSearchBarSearchButtonClicked:(SBSearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)SBSearchBarCancelButtonClicked:(SBSearchBar *)searchBar;                     // called when cancel button is pressed

- (BOOL)SBSearchBarShouldBeginEditing:(SBSearchBar *)searchBar;                      // return NO to not become first responder
- (void)SBSearchBarTextDidBeginEditing:(SBSearchBar *)searchBar;                     // called when text starts editing
- (BOOL)SBSearchBarShouldEndEditing:(SBSearchBar *)searchBar;                        // return NO to not resign first responder
- (void)SBSearchBarTextDidEndEditing:(SBSearchBar *)searchBar;                       // called when text ends editing

```
- in your code add follow code when you need show the SearchBar
```objective-c
SBSearchBar *searchBarCustom = [[SBSearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 35)]; //set your searchBar frame
searchBarCustom.delegate = self;

//if you need custom color, font, etc
[searchBarCustom setTextColor:[UIColor whiteColor]];
searchBarCustom.placeHolderColor = [UIColor whiteColor];
searchBarCustom.font = [UIFont fontWithName:@"Arial" size:14];

//you can set a custom lens image
searchBarCustom.lensImage = [UIImage imageNamed:@"ic_lens"]; 
//you can set a custom X image
searchBarCustom.cancelButtonImage = [UIImage imageNamed:@"FormReset"];

//you cand show an additional cancel button
searchBarCustom.addExtraCancelButton = YES;

[self.view addSubview:searchBarCustom];


```
####feedback?

* twitter: [@busta117](http://www.twitter.com/busta117)
* mail: <busta117@gmail.com>
* <http://www.santiagobustamante.info>


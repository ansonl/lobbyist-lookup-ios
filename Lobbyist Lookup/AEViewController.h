//
//  AEViewController.h
//  Lobbyist Lookup
//
//  Created by Anson Liu on 6/14/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestMenuData.h"
#import "AEShowLookupResult.h"

@interface AEViewController : UIViewController <UITextFieldDelegate> {
    CGRect inputViewOriginalFrame;
}

- (void)dataReady:(NSDictionary *)dict;
- (void)dataFailed:(NSString *)text;

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITextField *surnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *organizationTextField;
@property (weak, nonatomic) IBOutlet UITextField *clientTextField;
@property (weak, nonatomic) IBOutlet UIButton *lookupButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *legislationInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutAppButton;

- (IBAction)lookupButtonClicked:(id)sender;
- (IBAction)legislationInfoButtonClicked:(id)sender;
- (IBAction)aboutButtonClicked:(id)sender;

@end

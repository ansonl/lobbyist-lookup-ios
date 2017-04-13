//
//  AELegislationInfo.h
//  Lobbyist Lookup
//
//  Created by Anson Liu on 6/28/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import <dispatch/dispatch.h>

@interface AELegislationInfo : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

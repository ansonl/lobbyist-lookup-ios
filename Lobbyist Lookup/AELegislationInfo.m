//
//  AELegislationInfo.m
//  Lobbyist Lookup
//
//  Created by Anson Liu on 6/28/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import "AELegislationInfo.h"

@implementation AELegislationInfo

- (void)getText {
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self.activityIndicator setHidden:NO];
        [self.activityIndicator startAnimating];
    });
    
    NSError* error;
    NSString *tmp = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:legislationURL] encoding:NSUTF8StringEncoding error:&error];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        self.textView.text = tmp;
        [self.activityIndicator setHidden:YES];
        [self.activityIndicator stopAnimating];
        
        if (error) {
            self.textView.text = [NSString stringWithFormat:@"Unable to load updated legislation info.\n%@\n\nShort version:\nOffice of Government Ethics is proposing to extend the lobbyist gift ban to all federal employees.\nThe lobbyist gift ban prohibits to acceptance of gifts of over $25 in value from registered lobbyists and other unauthorized sources. ",[error localizedDescription]];
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.activityIndicator setHidden:YES];
    [self.activityIndicator setColor:[UIColor darkGrayColor]];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    dispatch_async(dispatch_queue_create("com.apparentetch.lobbyist-lookup", NULL), ^(void) {
        [self getText];
    });
    
    
}

@end

//
//  AEAppInfo.m
//  Lobbyist Lookup
//
//  Created by Anson Liu on 6/28/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import "AEAppInfo.h"

@implementation AEAppInfo

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    AECredits *credits = [[AECredits alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 900)];
    
    //[credits setBackgroundColor:[UIColor redColor]];
    
    [self.scrollView addSubview:credits];
    self.scrollView.contentSize = credits.frame.size;
     
    
    
}

@end
